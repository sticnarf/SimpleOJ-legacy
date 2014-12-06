class TestFile < ActiveRecord::Base
  mount_uploader :data, DataFileUploader

  belongs_to :problem

  validates :problem, presence: true
end
