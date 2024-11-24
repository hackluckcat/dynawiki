require "test_helper"

class LegalsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get legals_index_url
    assert_response :success
  end
end
