class ChangePassword < ActiveRecord::Migration
  def change
  	rename_column :users, :user_password, :password_digest
  end
end
