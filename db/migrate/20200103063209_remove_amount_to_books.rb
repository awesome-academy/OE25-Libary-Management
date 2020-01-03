class RemoveAmountToBooks < ActiveRecord::Migration[6.0]
  def change
    remove_column :books, :amount, :integer
  end
end
