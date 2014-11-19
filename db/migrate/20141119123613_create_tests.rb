class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.integer :submit_id
      t.integer :status
      t.integer :memory
      t.integer :time

      t.timestamps
    end
  end
end
