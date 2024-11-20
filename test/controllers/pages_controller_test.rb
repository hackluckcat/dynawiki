require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get when page is already exist" do
    get page_url(code: :en, title: "Dog")
    assert_response :success
  end

  test "should get when page is not exist" do
    get page_url(code: :en, title: "Car")
    assert_response :success
    assert_not_nil Page.find_by(title: "Car")
  end
end
