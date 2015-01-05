class Friend < ActiveRecord::Base
        def friendsaredifferent
        	if self.friend_creator == self.friend_recipient
				errors.add(:friend_creator, 'creator is the same as recipient')
				errors.add(:friend_recipient, 'recipient is the same as creator')
        	end
        end
        belongs_to :user
        validates :friend_creator, :uniqueness => {:scope => :friend_recipient}, presence: true
        validates :friend_recipient, presence: true
        validate :friendsaredifferent
end
