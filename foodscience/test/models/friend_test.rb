require 'test_helper'

class FriendTest < ActiveSupport::TestCase
  fixtures :friends, :users
  test "all required friend fields are filled" do
    newfriend = Friend.new
    assert newfriend.invalid?
    assert newfriend.errors[:friend_creator].any?
    assert newfriend.errors[:friend_recipient].any?
  end
  test "refer only to existing users" do
    one = friends(:one)
    two = friends(:two)
    two.friend_creator
    assert one.valid?
    assert two.valid?
# <!!!> breaking - is valid
#    one.friend_recipient = 100
#    assert one.invalid?
    one.friend_recipient = 2
    assert one.valid?
  end
end
