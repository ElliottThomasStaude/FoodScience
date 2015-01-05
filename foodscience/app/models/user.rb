class User < ActiveRecord::Base
	@valid_roles = [ "admin", "employee", "user" ]
	def self.valid_roles
		@valid_roles
	end
	has_many :userfriends, :through => :friends
	has_many :friends, :foreign_key => 'friend_creator', :foreign_key => 'friend_recipient', dependent: :destroy
	has_many :orders, :foreign_key => 'order_organizer', dependent: :destroy
	has_many :participants, :foreign_key => 'part_user', dependent: :destroy
	validates :user_name, length: {maximum: 50}, uniqueness: true, presence: {message: 'A user must have a user name.'}
	validates :user_email, length: {maximum: 50}, uniqueness: true, presence: {message: 'A user must have an e-mail.'}
	validates :user_role, length: {maximum: 50}, inclusion: @valid_roles, presence: {message: 'A user must have a valid role.'}
    validates_associated :friends
    has_secure_password
end
