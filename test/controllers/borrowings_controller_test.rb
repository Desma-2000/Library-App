require "test_helper"

class BorrowingsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get borrowings_new_url
    assert_response :success
  end

  test "should get create" do
    get borrowings_create_url
    assert_response :success
  end

  test "should get return" do
    get borrowings_return_url
    assert_response :success
  end

  test "should get history" do
    get borrowings_history_url
    assert_response :success
  end
end
