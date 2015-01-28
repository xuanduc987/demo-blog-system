require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = users(:duc)
    @entry = entries(:one)
    @comment = @user.comments.build(entry_id: @entry.id, content: "Testing")
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "content should be present" do
    @comment.content = ""
    assert_not @comment.valid?
  end

  test "user_id should be present" do
    @comment.user_id = nil
    assert_not @comment.valid?
  end

  test "entry_id should be present" do
    @comment.entry_id = nil
    assert_not @comment.valid?
  end
end
