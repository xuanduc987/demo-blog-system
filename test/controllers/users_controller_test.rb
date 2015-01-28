require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:duc)
    @other = users(:other)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect index when not logged" do
    get :index
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test "should redirect edit when not logged" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other)
    get :edit, id: @user
    assert flash.empty?
    assert_redirected_to root_path
  end

  test "should redirect update when not logged" do
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other)
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert flash.empty?
    assert_redirected_to root_path
  end

  test "should redirect following when not logged in" do
    get :following, id: @user
    assert_redirected_to login_url
  end

  test "should redirect followers when not logged in" do
    get :followers, id: @user
    assert_redirected_to login_url
  end
end
