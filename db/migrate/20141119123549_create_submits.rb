class CreateSubmits < ActiveRecord::Migration
  def change
    create_table :submits do |t|
      t.integer :problem_id
      t.integer :status
      t.integer :memory
      t.integer :time

      t.timestamps
    end
  end
end
