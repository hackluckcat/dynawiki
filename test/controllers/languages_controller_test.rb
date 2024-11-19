require "test_helper"

class LanguagesControllerTest < ActionDispatch::IntegrationTest
  test "should redirect to en when no header" do
    get root_url
    assert_response :redirect
    assert_redirected_to language_path(code: "en")
  end

  test "should redirect to ja when with ja header" do
    get root_url, headers: {
      "HTTP_ACCEPT_LANGUAGE" => "ja-JP"
    }
    assert_response :redirect
    assert_redirected_to language_path(code: "ja")
  end

  test "should redirect to en when with en header" do
    get root_url, headers: {
      "HTTP_ACCEPT_LANGUAGE" => "en-US"
    }
    assert_response :redirect
    assert_redirected_to language_path(code: "en")
  end

  test "should redirect to en when with fr header" do
    get root_url, headers: {
      "HTTP_ACCEPT_LANGUAGE" => "fr-CH"
    }
    assert_response :redirect
    assert_redirected_to language_path(code: "en")
  end

  test "should get show" do
    get language_url(code: "en")
    assert_response :success
  end
end
