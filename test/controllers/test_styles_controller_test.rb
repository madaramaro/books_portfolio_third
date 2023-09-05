require "test_helper"

class TestStylesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get test_styles_index_url
    assert_response :success
  end
end
