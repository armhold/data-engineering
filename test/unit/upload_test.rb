require 'test_helper'

class UploadTest < ActiveSupport::TestCase

  test "process file" do
    file = File.dirname(__FILE__) + "/../fixtures/files/sample1.tab"

    user = users(:one)

    upload = Upload.from_file file, user

    assert_equal 300, upload.gross_revenue
  end

  test "parser flags bad input" do
    file = File.dirname(__FILE__) + "/../fixtures/files/bad-input.tab"

    user = users(:one)

    exception = assert_raise(StandardError) { Upload.from_file file, user }
    assert_equal "error on line 2; did not find 6 fields", exception.message
  end

end
