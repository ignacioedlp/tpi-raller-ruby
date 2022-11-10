require "application_system_test_case"

class OpeningHoursTest < ApplicationSystemTestCase
  setup do
    @opening_hour = opening_hours(:one)
  end

  test "visiting the index" do
    visit opening_hours_url
    assert_selector "h1", text: "Opening hours"
  end

  test "should create opening hour" do
    visit opening_hours_url
    click_on "New opening hour"

    click_on "Create Opening hour"

    assert_text "Opening hour was successfully created"
    click_on "Back"
  end

  test "should update Opening hour" do
    visit opening_hour_url(@opening_hour)
    click_on "Edit this opening hour", match: :first

    click_on "Update Opening hour"

    assert_text "Opening hour was successfully updated"
    click_on "Back"
  end

  test "should destroy Opening hour" do
    visit opening_hour_url(@opening_hour)
    click_on "Destroy this opening hour", match: :first

    assert_text "Opening hour was successfully destroyed"
  end
end
