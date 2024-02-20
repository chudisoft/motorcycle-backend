class Api::V1::ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = current_user.reservations.includes(:motorcycle).all.order('created_at desc')
    serialized_reservations = @reservations.map do |reservation|
      {
        reservation: {
          id: reservation.id,
          quantity: reservation.quantity,
          reserve_time: reservation.reserve_time.strftime('%H:%M'),
          reserve_date: reservation.reserve_date
        },
        motorcycle: {
          id: reservation.motorcycle.id,
          name: reservation.motorcycle.name,
          image: reservation.motorcycle.image,
          price: reservation.motorcycle.price
        },
        total: {
          total_price: reservation.quantity.to_f * reservation.motorcycle.price
        }
      }
    end
    render json: serialized_reservations, status: :ok
  end

  def destroy
    @reservation = current_user.reservations.find(params[:id])
    if @reservation.destroy
      head :no_content
    else
      render json: 'Reservation could not be deleted'
    end
  end

  def create
    @motorcycle = motorcycle.find(params[:motorcycle_id])
    existing_reservation = current_user.reservations.find_by(
      motorcycle: @motorcycle,
      reserve_time: params[:reservation][:reserve_time],
      reserve_date: params[:reservation][:reserve_date],
      spicy_level: params[:reservation][:spicy_level]
    )
    if existing_reservation
      new_quantity = existing_reservation.quantity + params[:reservation][:quantity].to_i
      existing_reservation.update(quantity: new_quantity)
      render json: existing_reservation, status: :ok
    else
      @reservation = @motorcycle.reservations.new(reservation_params.merge(user: current_user))
      if @reservation.save
        render json: @reservation, status: :ok
      else
        render json: { data: @reservation.errors.full_messages, message: "Couldn't create the reservation" },
               status: :unprocessable_entity
      end
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:reserve_time, :city, :quantity, :motorcycle_id, :reserve_date)
  end
end
