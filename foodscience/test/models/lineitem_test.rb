require 'test_helper'

class LineitemTest < ActiveSupport::TestCase
  fixtures :friends, :lineitems, :orders, :participants, :restaurants, :users
  test "all required lineitem fields are filled" do
    newline = Lineitem.new
    assert newline.invalid?
    assert newline.errors[:line_part].any?
    assert newline.errors[:line_order].any?
    assert newline.errors[:line_name].any?
    assert newline.errors[:line_price].any?
  end
  test "lineitem prices are constrained appropriately" do
    lineone = lineitems(:one)
    lineone.line_price = 2.49
    assert lineone.valid?
    lineone.line_price = 0.001
    assert lineone.invalid?
    lineone.line_price = -0.01
    assert lineone.invalid?
    lineone.line_price = 0.0
    assert lineone.invalid?
    lineone.line_price = 0.1
    assert lineone.invalid?
    lineone.line_price = 0.00
    assert lineone.invalid?
  end
  test "lineitem names are constrained appropriately" do
	linetwo = lineitems(:two)
	linetwo.line_name = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
	linetwo.invalid?
	linetwo.line_name = ""
	linetwo.invalid?
	linetwo.line_name = "A Product"
	linetwo.valid?
  end
end
