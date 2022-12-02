require "test_helper"

class OpeningHoursControllerTest < ActionDispatch::IntegrationTest
  setup do
    @opening_hour = opening_hours(:one)
  end

  test "should get index" do
    get opening_hours_url
    assert_response :success
  end

  test "should get new" do
    get new_opening_hour_url
    assert_response :success
  end

  test "should create opening_hour" do
    assert_difference("OpeningHour.count") do
      post opening_hours_url, params: {opening_hour: {}}
    end

    assert_redirected_to opening_hour_url(OpeningHour.last)
  end

  test "should show opening_hour" do
    get opening_hour_url(@opening_hour)
    assert_response :success
  end

  test "should get edit" do
    get edit_opening_hour_url(@opening_hour)
    assert_response :success
  end

  test "should update opening_hour" do
    patch opening_hour_url(@opening_hour), params: {opening_hour: {}}
    assert_redirected_to opening_hour_url(@opening_hour)
  end

  test "should destroy opening_hour" do
    assert_difference("OpeningHour.count", -1) do
      delete opening_hour_url(@opening_hour)
    end

    assert_redirected_to opening_hours_url
  end
end
