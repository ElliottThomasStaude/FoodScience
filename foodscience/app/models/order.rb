class Order < ActiveRecord::Base
	@valid_statuses = [ "pending", "placed" ]
	def self.valid_statuses
		@valid_statuses
	end
    belongs_to :restaurant
    belongs_to :user
	has_many :lineitems, :foreign_key => 'line_order', dependent: :destroy
	has_many :participants, :foreign_key => 'part_order', dependent: :destroy
	validates :order_rest, presence: true
	validates :order_organizer, presence: true
	validates :order_cost, numericality: {greater_than_or_equal_to: 0.01}, presence: true
	validates :order_time_at, presence: true
	validates :order_status, inclusion: @valid_statuses, length: {maximum: 20}, presence: true
end
