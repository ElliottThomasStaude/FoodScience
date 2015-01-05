class Participant < ActiveRecord::Base
	@valid_roles = [ "organizer", "participant" ]
	def self.valid_roles
		@valid_roles
	end
    belongs_to :user
    belongs_to :order
	has_many :lineitems, :foreign_key => 'line_part', dependent: :destroy
	validates :part_user, presence: true
    validates :part_order, presence: true
    validates :part_role, length: {maximum: 20}, inclusion: @valid_roles, presence: true
    validates :part_cost, numericality: {greater_than_or_equal_to: 0.00}, presence: true
end
