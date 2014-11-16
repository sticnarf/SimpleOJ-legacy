class AddDefaultToCounts < ActiveRecord::Migration
  def change
    change_column :problems, :pass_count, :integer, :default => 0
    change_column :problems, :submit_count, :integer, :default => 0
  end
end
