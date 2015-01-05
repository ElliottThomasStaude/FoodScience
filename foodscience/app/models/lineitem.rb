class Lineitem < ActiveRecord::Base
    belongs_to :order
    belongs_to :participant
	validates :line_part, presence: true
	validates :line_order, presence: true
	validates :line_name, length: {maximum: 100}, presence: true
	validates :line_price, numericality: true, :format => {:with => /\A\d{1,8}.\d{2}\z/}, presence: true
end
