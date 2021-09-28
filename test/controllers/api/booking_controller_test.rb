require 'test_helper'

class BookingControllerTest < ActionDispatch::IntegrationTest

  setup do
    @john_doe = users(:john_doe)
  end

  test "should get a user's bookings" do
    get api_user_bookings_url(@john_doe), headers: authenticated_header, xhr: true
    bookings = JSON.parse(@response.body)
    assert bookings.length == 2, "There are #{bookings.length} bookings instead of 2"
    assert bookings.all? { |booking| booking["user"]["id"] == @john_doe.id }, "Returned bookings aren't all owned by #{@john_doe.firstname} #{@john_doe.lastname}"
  end

  test "should save a new booking" do
    booking_hash = {
      "start_date": DateTime.new(2017,12,1,12,0,0).iso8601,
      "end_date": DateTime.new(2017,12,2,12,0,0).iso8601
    }

    post api_user_bookings_url(@john_doe), headers: authenticated_header, params: { booking: booking_hash }, xhr: true
    assert_response 201
    booking = JSON.parse(@response.body)
    assert_not_nil booking["id"], "The booking ID is null"
  end

  def authenticated_header
    token = Knock::AuthToken.new(payload: { sub: @john_doe.id }).token

    return { 'Authorization': "Bearer #{token}" }
  end

end
