class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :name
      t.references :author, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.references :publisher, null: false, foreign_key: true
      t.integer :price
      t.integer :amount
      t.integer :rest_amount

      t.timestamps
    end
  end
end
