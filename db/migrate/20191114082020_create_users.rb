class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :sex
      t.date :birth
      t.string :email
      t.string :address
      t.string :phone
      t.string :identity_card
      t.integer :role

      t.timestamps
    end
  end
end
