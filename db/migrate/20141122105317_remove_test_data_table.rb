class RemoveTestDataTable < ActiveRecord::Migration
  def change
    drop_table :test_data
  end
end
