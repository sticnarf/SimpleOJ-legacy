class AddCodeToSubmit < ActiveRecord::Migration
  def change
    add_column :submits, :code, :text
  end
end
