require 'open3'
require 'lrun'
require 'fileutils'
class CompileWorker
  include Sidekiq::Worker
  def perform(submit_id)
    submit = Submit.find_by(id: submit_id)
    submit.compiling!
    problem = submit.problem
    file_name = "#{Time.now.to_i}P#{problem.id}S#{submit.id}"
    system("mkdir /tmp/#{file_name}")
    f = File.open("/tmp/#{file_name}/code.#{submit.language}", "w")
    f.write(submit.code)
    f.close
    success, info = eval("#{submit.language}(file_name)")
    submit.update_attribute(:compiler_info, info)
    if success
      submit.judging!
      # FileUtils::chmod(0777, "/tmp/#{file_name}/code")
      # FileUtils::chown('vagrant', 'lrun', "/tmp/#{file_name}/code")
      TestWorker.perform_async(submit_id, file_name)
    else
      submit.compileE!
    end
  end

  private

  def c(file_name)
    result = Lrun.run("cc /tmp/#{file_name}/code.c -o /tmp/#{file_name}/code")
    if result.exitcode == 0
      return true, result.stdout
    else
      return false, result.stderr
    end
    # Open3.popen3('gcc', "/tmp/#{file_name}/code.c", '-o', "/tmp/#{file_name}/code") do |stdin, stdout, stderr, wait_thr|
#       if wait_thr.value.success?
#         return true, stdout.gets(nil)
#       else
#         return false, stderr.gets(nil)
#       end
#     end
  end

  def cpp(file_name)
    result = Lrun.run("c++ /tmp/#{file_name}/code.c -o /tmp/#{file_name}/code")
    if result.exitcode == 0
      return true, result.stdout
    else
      return false, result.stderr
    end
    # Open3.popen3('g++', "/tmp/#{file_name}/code.cpp", '-o', "/tmp/#{file_name}/code") do |stdin, stdout, stderr, wait_thr|
#       if wait_thr.value.success?
#         return true, stdout.gets(nil)
#       else
#         return false, stderr.gets(nil)
#       end
#     end
  end

  def pas(file_name)
    result = Lrun.run("fpc /tmp/#{file_name}/code.pas")
    return result.exitcode == 0, result.stdout
    # Open3.popen3('fpc', "/tmp/#{file_name}/code.pas") do |stdin, stdout, stderr, wait_thr|
#       return wait_thr.value.success?, stdout.gets(nil)
#     end
  end
end