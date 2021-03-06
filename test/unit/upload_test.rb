require 'test_helper'

class UploadTest < ActiveSupport::TestCase

  test "process files" do
    user = users(:one)

    file = Rack::Test::UploadedFile.new("#{Rails.root}/test/fixtures/files/sample1.tab", "text/plain")
    upload = Upload.from_file file, user
    assert_equal 300, upload.gross_revenue

    file = Rack::Test::UploadedFile.new("#{Rails.root}/test/fixtures/files/sample2.tab", "text/plain")
    upload = Upload.from_file file, user
    assert_equal 3.30, upload.gross_revenue
  end

  test "parser flags bad input" do
    file = Rack::Test::UploadedFile.new("#{Rails.root}/test/fixtures/files/bad-input.tab", "text/plain")
    user = users(:one)

    assert_no_difference(%w(Upload.count Purchase.count Item.count Merchant.count Address.count Customer.count)) do
      assert_equal "error on line 2; found 5 fields instead of 6", Upload.from_file(file, user).errors.full_messages.to_sentence
    end

  end

  test "merchants can have multiple addresses" do
    file = Rack::Test::UploadedFile.new("#{Rails.root}/test/fixtures/files/multi-address-merchants.tab", "text/plain")
    user = users(:one)

    upload = Upload.from_file file, user
    assert upload.valid?,  upload.purchases.inject { |s, p| "#{s}, #{p.errors.messages.to_s}" }

    upload = Upload.find(upload.id)

    # first and 2nd purchases are by the same merchant, but with different addresses
    assert_equal "123 main st", upload.purchases[0].address.street
    assert_equal "400 broadway", upload.purchases[1].address.street

    # different merchants can have the same address
    assert_equal "123 fake st", upload.purchases[2].address.street
    assert_equal "123 fake st", upload.purchases[3].address.street

    # should be different DB entry, even though address is textually identical
    assert_not_equal upload.purchases[2].address.id, upload.purchases[3].address.id
  end

end
