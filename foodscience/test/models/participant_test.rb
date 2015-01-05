require 'test_helper'

class ParticipantTest < ActiveSupport::TestCase
  fixtures :friends, :lineitems, :orders, :participants, :restaurants, :users
  test "all required participant fields are filled" do
    newpart = Participant.new
    assert newpart.invalid?
    assert newpart.errors[:part_user].any?
    assert newpart.errors[:part_role].any?
    assert newpart.errors[:part_order].any?
    assert newpart.errors[:part_cost].any?
  end
  test "part_role is restricted appropriately" do
    one = participants(:one)
    one.part_role = "invalid"
    one.invalid?
    one.part_role = ""
    one.invalid?
    one.part_role = "organizer"
    one.valid?
  end
  test "part_cost is a valid number" do
    one = participants(:one)
    one.part_cost = 0.001
    assert one.invalid?
    one.part_cost = -0.01
    assert one.invalid?
    one.part_cost = 2.49
    assert one.valid?
    one.part_cost = 0.00
    assert one.invalid?
  end
  test "part_user is correctly restricted over the scope of part_order" do
    one = participants(:one)
    two = participants(:two)
    one.part_user = 1
    two.part_user = 2
    one.part_order = 1
    two.part_order = 1
    assert one.valid?
    assert two.valid?
  end
end
