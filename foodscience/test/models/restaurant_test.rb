require 'test_helper'

class RestaurantTest < ActiveSupport::TestCase
  test "all required restaurant fields are filled" do
    newrest = Restaurant.new
    assert newrest.invalid?
    assert newrest.errors[:rest_name].any?
    assert newrest.errors[:rest_cuisine].any?
    assert newrest.errors[:rest_firstaddr].any?
    assert newrest.errors[:rest_city].any?
    assert newrest.errors[:rest_state].any?
    assert newrest.errors[:rest_zip].any?
    assert newrest.errors[:rest_phone].any?
    assert newrest.errors[:rest_url].any?
  end
  test "rest_fee is a valid number" do
    one = restaurants(:one)
    one.rest_fee = 0.00
    assert one.invalid?
    one.rest_fee = -0.01
    assert one.invalid?
    one.rest_fee = 2.49
    assert one.valid?
  end
  test "all restrictions on rest_cuisine are enforced" do
    one = restaurants(:one)
    one.rest_cuisine = "invalid"
    assert one.invalid?
    one.rest_cuisine = ""
    assert one.invalid?
    Restaurant.cuisine_kinds.each do |kind|
    	one.rest_cuisine = kind
    	assert one.valid?
    end
  end
end
