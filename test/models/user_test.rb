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

  test "associated entries should be destroyed" do
    @user.save
    @user.entries.create!(title: "Test", content: "Just testing")
    assert_difference 'Entry.count', -1 do
      @user.destroy
    end
  end

  test "associated comments should be destroyed" do
    @user.save
    entry = @user.entries.create!(title: "Temp", content:"wa")
    @user.comments.create!(entry_id: entry.id, content: "Sad")
    assert_difference 'Comment.count', -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow a user" do
    duc = users(:duc)
    other  = users(:other)
    assert_not duc.following?(other)
    duc.follow(other)
    assert duc.following?(other)
    assert other.followers.include?(duc)
    duc.unfollow(other)
    assert_not duc.following?(other)
  end

  test "feed should have the right posts" do
    duc = users(:duc)
    other  = users(:other)
    thai    = users(:thai)
    # Posts from followed user
    thai.entries.each do |post_following|
      assert duc.feed.include?(post_following)
    end
    # Posts from self
    duc.entries.each do |post_self|
      assert duc.feed.include?(post_self)
    end
    # Posts from unfollowed user
    other.entries.each do |post_unfollowed|
      assert_not duc.feed.include?(post_unfollowed)
    end
  end
end
