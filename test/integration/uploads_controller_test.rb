require 'test_helper'

class UploadsControllerTest < ActionController::TestCase

  test "cannot access uploads page when not logged in" do
    get :index

    assert_redirected_to new_session_path
  end

  test "can access uploads page after login" do
    user = users(:one)
    @request.session[:user_id] = user

    get :index

    assert_equal "200", response.code
    assert_select "div#upload-page", { :count => 1}
    assert_select "h2#welcome", { :count => 1, :text => "Welcome, John [ Logout ]" }
  end

end
