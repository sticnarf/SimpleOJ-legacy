class CreateTestFiles < ActiveRecord::Migration
  def change
    create_table :test_files do |t|
      t.integer :problem_id
      t.column :data, :oid, :null => false

      t.timestamps
    end
  end
end
