class AddDefaultStatusToSubmits < ActiveRecord::Migration
  def change
    change_column :submits, :status, :integer, :default => 0
  end
end
