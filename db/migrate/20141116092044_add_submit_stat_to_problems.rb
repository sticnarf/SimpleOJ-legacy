class AddSubmitStatToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :pass_count, :integer
    add_column :problems, :submit_count, :integer
  end
end
