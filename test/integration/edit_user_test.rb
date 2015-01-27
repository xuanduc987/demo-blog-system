require 'test_helper'

class EditUserTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:duc)
  end

  test "successful edit" do
    log_in_as(@user)
    name = "Faker2"
    email = "faker992@gmail.com"
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { name: name, email: email, password: "",
                                    password_confirmation: "" }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name, name
    assert_equal @user.email, email
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { name: "", email: "invalid@a,com", 
                                    password: "abcdef", password_confirmation: ""}
    assert_template 'users/edit'
  end
end
