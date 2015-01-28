require 'test_helper'

class EntriesControllerTest < ActionController::TestCase
  def setup
    @entry = entries(:one)
  end
  test "should redirect create when not logged in" do
    assert_no_difference 'Entry.count' do
      post :create, entry: { content: "test entry" }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Entry.count' do
      delete :destroy, id: @entry
    end
    assert_redirected_to login_url
  end
end
