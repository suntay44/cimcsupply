require "test_helper"

class SuppliesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get supplies_index_url
    assert_response :success
  end

  test "should get show" do
    get supplies_show_url
    assert_response :success
  end
end
