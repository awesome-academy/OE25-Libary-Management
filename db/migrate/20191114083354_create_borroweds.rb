class CreateBorroweds < ActiveRecord::Migration[6.0]
  def change
    create_table :borroweds do |t|
      t.references :user, null: false, foreign_key: true
      t.date :borrow_day
      t.date :return_day
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
