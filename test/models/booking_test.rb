require 'test_helper'

class BookingTest < ActiveSupport::TestCase
  setup do
    @booking = Booking.new
    @booking.user = users(:john_doe)
    @booking.start_date = Time.local(2017, 1, 1, 12, 0, 0).to_date
    @booking.end_date = Time.local(2017, 1, 2, 16, 30, 0).to_date
  end

  test "should be valid with all attributes" do
    assert @booking.valid?
  end

  test "should not be valid without user" do
    @booking.user = nil
    assert_not @booking.valid?
  end

  test "should not be valid without start date" do
    @booking.start_date = nil
    assert_not @booking.valid?
  end

  test "should not be valid without end date" do
    @booking.end_date = nil
    assert_not @booking.valid?
  end
end
