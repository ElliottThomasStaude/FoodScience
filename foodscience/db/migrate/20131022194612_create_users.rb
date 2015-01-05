class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name, null: false, limit: 50
      t.string :user_email, null: false, limit: 50
      t.string :user_password, null: false, limit: 50
      t.string :user_role, null: false, limit: 50

      t.timestamps
    end
  end
end
