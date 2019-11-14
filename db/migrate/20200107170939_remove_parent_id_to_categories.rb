class RemoveParentIdToCategories < ActiveRecord::Migration[6.0]
  def change
    remove_column :categories, :parent_id, :integer
  end
end
