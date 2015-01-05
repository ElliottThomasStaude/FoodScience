require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  fixtures :friends, :lineitems, :orders, :participants, :restaurants, :users
  test "all required order fields are filled" do
    neworder = Order.new
    assert neworder.invalid?
    assert neworder.errors[:order_rest].any?
    assert neworder.errors[:order_organizer].any?
    assert neworder.errors[:order_cost].any?
    assert neworder.errors[:order_time_at].any?
    assert neworder.errors[:order_status].any?
  end
  test "order restaurant number is valid" do
    one = orders(:one)
    one.order_rest = 12
    one.invalid?
  end
  test "order restaurant status is restricted appropriately" do
    one = orders(:one)
    one.order_status = "invalid"
    one.invalid?
    one.order_status = ""
    one.invalid?
    one.order_status = "pending"
    one.valid?
  end
  test "order_cost is a valid number" do
    two = orders(:two)
    two.order_cost = 0.00
    assert two.invalid?
    two.order_cost = -0.01
    assert two.invalid?
    two.order_cost = 2.49
    assert two.valid?
  end
end
