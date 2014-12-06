class Submit < ActiveRecord::Base

  has_many :tests
  belongs_to :problem

  enum status: [:waiting, :judging, :compiling, :compileE, :timeE, :accepted, :wrong, :memoryE, :runtimeE]

  enum language: [:c, :cpp, :pas]

  def status_name
    dict = {
      waiting: '等待中',
      judging: '评测中',
      compiling: '编译中',
      compileE: '编译错误',
      timeE: '运行超时',
      accepted: '通过',
      wrong: '答案错误',
      memoryE: '超过内存限制',
      runtimeE: '运行时错误'
    }
    dict[self.status]
  end
end
