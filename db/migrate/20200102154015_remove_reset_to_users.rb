class RemoveResetToUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :reset_digest, :string
    remove_column :users, :reset_sent_at, :string
  end
end
