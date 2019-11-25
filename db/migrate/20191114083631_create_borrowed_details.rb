class CreateBorrowedDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :borrowed_details do |t|
      t.references :borrowed, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.integer :quantity, default: 1

      t.timestamps
    end
  end
end
