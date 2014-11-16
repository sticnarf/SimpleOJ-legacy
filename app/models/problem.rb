class Problem < ActiveRecord::Base
  def pass_ratio
    return 0 if self.submit_count == 0
    self.pass_count * 100 / self.submit_count
  end
end
