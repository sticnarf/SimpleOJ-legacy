require 'open3'
require 'lrun'
class TestWorker
  include Sidekiq::Worker
  def perform(submit_id, file_name)
    submit = Submit.find_by(id: submit_id)
    problem = submit.problem
    test_file_path = "/tmp/#{file_name}/#{problem.abbr}.zip"
    # test_file = File.open(test_file_path, "w")
    IO.binwrite(test_file_path, problem.test_file.data.read)
    # test_file.close
    index = 1
    Open3.popen3('unzip', '-j', '-o', test_file_path, '-d', "/tmp/#{file_name}")  do |stdin, stdout, stderr, wait_thr|
      if wait_thr.value.success?
        while File::exists?("/tmp/#{file_name}/#{problem.abbr}#{index}.in")
          test(submit_id, file_name, index)
          index += 1
        end
        count = index - 1
        passed = 0
        status = :accepted
        memory = 0
        time = 0
        submit.tests.each do |t|
          memory = [memory, t.memory].max
          time = [time, t.time].max
          case t.status.to_sym
          when :accepted
            passed += 1
          when :wrong
            status = :wrong if status == :accepted
          when :runtimeE
            status = :runtimeE if status == :accepted
          when :timeE
            status = :timeE if status == :accepted
          when :memoryE
            status = :memoryE if status == :accepted
          end
        end
        submit.update_attributes(score: (passed.to_f / count * 100).round, status: status, memory: memory, time: time)

      end
    end
  end

  def test(submit_id, file_name, index)
    submit = Submit.find_by(id: submit_id)
    problem = submit.problem
    system("mv /tmp/#{file_name}/#{problem.abbr}#{index}.in /tmp/#{file_name}/#{problem.abbr}.in")
    # runner = Lrun::Runner.new(:max_cpu_time=>1, :max_memory => 2**27, :network => false,
    #   :tmpfs=>[["/tmp/#{file_name}", 2**25]], :chdir=>"/tmp/#{file_name}")
    runner = Lrun::Runner.new(:max_cpu_time=>1, :max_memory => 2**27, :network => false, :chdir=>"/tmp/#{file_name}")
    result = runner.run("/tmp/#{file_name}/code")
    test = Test.new(submit_id: submit_id, time: result.cputime, memory: result.memory)
    if result.signal
      test.status = :runtimeE
    elsif result.exceed == :time
      test.status = :timeE
    elsif result.exceed == :memory
      test.status = :memoryE
    else
      diff_result = Lrun.run("diff -Z -B /tmp/#{file_name}/#{problem.abbr}.out /tmp/#{file_name}/#{problem.abbr}#{index}.ans").stdout
      if diff_result.length > 2
        test.status = :wrong
      else
        test.status = :accepted
      end
      # Open3.popen3('diff', '-Z', '-B', "/tmp/#{file_name}/#{problem.abbr}.out", "/tmp/#{file_name}/#{problem.abbr}#{index}.ans") do |stdin, stdout, stderr, wait_thr|
#         if stdout.gets(nil).length > 2
#           test.status = :wrong
#         else
#           test.status = :accepted
#         end
#       end
    end
    Lrun.run("rm /tmp/#{file_name}/#{problem.abbr}.out")
    test.save
  end
end