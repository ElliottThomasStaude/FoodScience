class Restaurant < ActiveRecord::Base
	@cuisine_kinds = [ "Chinese", "East European", "French", "Greek", "Hungarian", "Italian", "Japanese", "Mexican", "New English", "Russian", "Spanish", "Thai" ]
	def self.cuisine_kinds
		@cuisine_kinds
	end
	has_many :orders, :foreign_key => 'order_rest', dependent: :destroy
	validates :rest_name, :rest_cuisine, :rest_firstaddr, :rest_city, :rest_state, :rest_zip, :rest_phone, :rest_url, presence: {message: "A restaurant needs to have a name, cuisine type, street address, city, state, zip code, phone number, and URL."}
	validates :rest_firstaddr, :rest_secondaddr, :rest_url, length: {maximum: 100}
	validates :rest_name, :rest_city, length: {maximum: 50}
	validates :rest_cuisine, length: {maximum: 20}, inclusion: @cuisine_kinds
	validates :rest_phone, :rest_fax, length: {maximum: 20}, numericality: {message: "Phone and fax contents must be numbers."}, allow_blank: true
	validates :rest_zip, length: {maximum: 10}
	validates :rest_state, length: {minimum: 2, maximum: 2}, allow_blank: true
	validates :rest_fee, numericality: {greater_than_or_equal_to: 0.00}, allow_blank: true
	validates :rest_name, :rest_firstaddr, :rest_url, :rest_phone, uniqueness: true
end
