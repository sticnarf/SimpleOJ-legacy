class Submit < ActiveRecord::Base

  has_many :tests
  belongs_to :problem

  enum status: [:waiting, :judging, :compiling, :compileE, :timeE, :accepted, :wrong, :memoryE]
end
