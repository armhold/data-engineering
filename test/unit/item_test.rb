require 'test_helper'

class ItemTest < ActiveSupport::TestCase

  # test that we are using a proper decimal type for currency
  # 0.1 + 0.2 will produce 0.30000000000000004 if using float rather than BigDecimal
  #
  test "using precision of money" do

    item1 = Item.new
    item1.price = 0.10

    item2 = Item.new
    item2.price = 0.20

    assert_equal 0.10, item1.price
    assert_equal 0.20, item2.price
    assert_equal 0.30, item1.price + item2.price
  end

end
