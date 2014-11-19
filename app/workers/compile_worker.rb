class CompileWorker
  include Sidekiq::Worker
  def perform(submit_id)
    submit = Submit.find_by(id: submit_id)
    problem = submit.problem
    file_name = "#{problem.id}_#{submit.id}_#{Time.now.to_i}"
    f = File.open("/tmp/#{file_name}.cpp", "w")
    f.write(submit.code)
    f.close
    system("cc /tmp/#{file_name}.cpp -o /tmp/#{file_name}.out")
  end
end