require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:duc)
  end

  test "index including pagination" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
    end
    second_page_of_users = User.paginate(page: 2)
    second_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name, count: 0
    end
  end
end
