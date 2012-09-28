require 'test_helper'

class UploadsControllerTest < ActionController::TestCase

  test "cannot access uploads page when not logged in" do
    get :new

    assert_redirected_to new_session_path
  end

  test "can access uploads page after login" do
    user = users(:one)
    @request.session[:user_id] = user

    get :new

    assert_equal "200", response.code
    assert_select "div#upload-page", { :count => 1}
    assert_select "h2#welcome", { :count => 1, :text => "Welcome, John [ Logout ]" }
  end

  test "users can access their own uploads" do
    user = users(:one)
    @request.session[:user_id] = user

    upload = uploads(:u1)
    get :show, id: upload

    assert_equal "200", response.code
    assert_select "h1", { :count => 1, :text => "View Upload # #{upload.id}" }
  end

  test "users cannot access other users' uploads" do
    user = users(:one)
    @request.session[:user_id] = user

    upload = uploads(:u2)
    get :show, id: upload

    assert_equal "403", response.code
    assert_select "h1", { :count => 1, :text => "Access Denied" }
  end

end
