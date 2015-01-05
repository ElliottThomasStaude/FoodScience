require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users
  test "all required user fields are filled" do
    newuser = User.new
    assert newuser.invalid?
    assert newuser.errors[:user_name].any?
    assert newuser.errors[:user_email].any?
    assert newuser.errors[:password].any?
    assert newuser.errors[:user_role].any?
  end
  test "all fields are below the maximum limit" do
  	five = users(:five)
  	assert five.invalid?
  	#five.attributes.each_pair do |colname, colnaval|
	#	five.attributes.each_pair do |colcheck, colchval|
	#		if colname == colname
	#			five.{colname} = "valid"
	#			if colname == "user_role"
	#				five.{colname} = "user"
	#			end
	#		else
	#			five.{colname} = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
	#		end
  	#	end
  	#end
  	five.user_name = "valid"
  	five.user_email = "valid"
  	five.password_digest = "valid"
  	five.user_role = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
  	assert five.invalid?
  	five.user_name = "valid"
  	five.user_email = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
  	five.password_digest = "valid"
  	five.user_role = "user"
  	assert five.invalid?
  	five.user_name = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
  	five.user_email = "valid"
  	five.password_digest = "valid"
  	five.user_role = "user"
  	assert five.invalid?
  	five.user_name = "valid"
  	five.user_email = "valid"
  	five.password_digest = "valid"
  	five.user_role = "user"
  	assert five.valid?
  end
  test "all restrictions on user role are enforced" do
    four = users(:four)
    assert four.valid?
    four.user_role = "dead"
    assert four.invalid?
    four.user_role = ""
    assert four.invalid?
    User.valid_roles.each do |role|
    	four.user_role = role
    	four.valid?
    end
  end
  test "user range is robust" do
    one = users(:one)
    two = users(:two)
    three = users(:three)
	assert one.valid?
	assert two.valid?
	assert three.valid?
  end
end
