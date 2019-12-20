class RenameColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :authors, :decription, :description
  end
end
