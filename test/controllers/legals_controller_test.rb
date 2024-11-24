# frozen_string_literal: true

class LegalsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get legals_url(code: :en)
    assert_response :success
  end
end
