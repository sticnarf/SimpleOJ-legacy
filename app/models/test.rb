class Test < ActiveRecord::Base
  enum status: [:timeE, :accepted, :wrong, :memoryE, :runtimeE]
end
