class Api::BookingsController < ApplicationController
  before_action :authenticate_user

  def index
    bookings = Booking.where(user_id: params[:user_id])
    render json: bookings, include: [:user]
  end

  def create
    booking = Booking.new
    booking.user = User.find(params[:user_id])
    booking.start_date = Time.iso8601(params[:booking]["start_date"])
    booking.end_date = Time.iso8601(params[:booking]["end_date"])

    booking.save
    render json: booking, status: 201
  end
end
