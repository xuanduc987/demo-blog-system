require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(email: "valid@server.com", name: "Faker",
                     password: "password", password_confirmation: "password")
  end

  test "should be valid" do
    assert @user.valid?, "#{@user.inspect} should be valid"
  end

  test "name must be present" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "name must not be longer than 50 character" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email must be present" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "email must not be longer than 255 character" do
    @user.name = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid email" do
    valid_addr = %w[foo@bar.com FoO@baz.com duc.nx@framgia.com
                    good+bad@google.com.uk a_bc-d@xyz.COM]
    valid_addr.each do |addr|
      @user.email = addr
      assert @user.valid?, "#{addr.inspect} should be valid"
    end
  end

  test "email validation should reject invalid email" do
    invalid_addr = %w[foobar@example,com foo@example bar@xyz+vn.com
                      dumb@..com bar_at_work.org abc@x. xyz@y_b.com]
    invalid_addr.each do |addr|
      @user.email = addr
      assert_not @user.valid?, "#{addr.inspect} should be invalid"
    end
  end

  test "email should be unique" do
    dup_user = @user.dup
    dup_user.email = @user.email.upcase
    @user.save
    assert_not dup_user.valid?
  end

  test "email should be save as lower case" do
    original_email = "FoObAR@EXamPLe.COM"
    @user.email = original_email
    @user.save
    assert_equal original_email.downcase, @user.reload.email
  end

  test "password should has a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

end
