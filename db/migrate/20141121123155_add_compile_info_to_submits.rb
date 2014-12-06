class AddCompileInfoToSubmits < ActiveRecord::Migration
  def change
    add_column :submits, :compiler_info, :text
  end
end
