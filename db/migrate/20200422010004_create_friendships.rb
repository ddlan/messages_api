class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.integer :user_one_id
      t.integer :user_two_id
      t.integer :status_code
      t.integer :action_user_id
      t.timestamps
    end
    add_index :friendships, %i[user_one_id user_two_id], unique: true
  end
end
