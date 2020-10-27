class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :user, references: :users, foreign_key: { to_table: :users }
      t.references :friend_id, index: true
      t.boolean :confirmed, default: :false 

      t.timestamps
    end
    add_foreign_key :friendships, :users, column: :friend_id
  end
end
