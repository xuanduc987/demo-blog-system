require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  def setup
    @user = users(:duc)
    @entry = @user.entries.build(title: "Title go herer",
                                 content: "This is a new entry")
  end

  test "should be valid" do
    assert @entry.valid?
  end

  test "user id should be present" do
    @entry.user_id = nil
    assert_not @entry.valid?
  end

  test "content should be present" do
    @entry.content = ""
    assert_not @entry.valid?
  end

  test "title should be present" do
    @entry.title = ""
    assert_not @entry.valid?
  end

  test "title should not be longer than 255 character" do
    @entry.title = "a" * 256
    assert_not @entry.valid?
  end

  test "order should be most recent first" do
    assert_equal Entry.first, entries(:most_recent)
  end

  test "associated comments should be deleted" do
    @entry.save
    @entry.comments.create!(content: "test", user_id: @user.id)
    assert_difference "Comment.count", -1 do
      @entry.destroy
    end
  end
end
