class AddLanguageToSubmits < ActiveRecord::Migration
  def change
    add_column :submits, :language, :integer
  end
end
