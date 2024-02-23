class Api::V1::ReservationsController < ApplicationController
  before_action :authorize_request
  def index
    @reservations = @current_user.reservations
    render json: { success: true, data: @reservations }
  end

  def show
    @reservation = @current_user.reservations.find(params[:id])
    render json: { success: true, data: @reservation }
  rescue ActiveRecord::RecordNotFound
    render json: { error: true, message: 'Reservation not found' }, status: :not_found
  end

  def destroy
    @reservation = @current_user.reservations.find(params[:id])
    if @reservation.destroy
      render json: { success: true, message: 'Reservation was deleted ' }
    else
      render json: 'Reservation could not be deleted'
    end
  end

  def create
    @reservation = @current_user.reservations.build(reservation_params)
    if @reservation.save
      render json: { success: true, message: 'Reservation was created' }, status: :created
    else
      render json: { error: true, message: @reservation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:reserve_date, :city, :motorcycle_id, :reserve_time)
  end
end
