class AddScoreToSubmits < ActiveRecord::Migration
  def change
    add_column :submits, :score, :integer
  end
end
