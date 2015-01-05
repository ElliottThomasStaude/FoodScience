class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.belongs_to :user
      t.integer :friend_creator, null: false
      t.integer :friend_recipient, null: false

      t.timestamps
    end
  end
end
