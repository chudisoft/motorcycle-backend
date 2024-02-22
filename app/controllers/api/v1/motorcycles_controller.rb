class Api::V1::MotorcyclesController < ApplicationController
  before_action :authorize_request
  before_action :set_motorcycle, only: %i[show destroy]


  def index
    motorcycles = Motorcycle.all
    if motorcycles.empty?
      render json: { errors: 'No motorcycles found', motorcycles: }
    else
      render json: { message: 'Motorcycles found', motorcycles: }
    end
  end

  def show
    @motorcycle = Motorcycle.find(params[:id])
    render json: @motorcycle
  end

  def motorcycles_available
    @motorcycles = current_user.motorcycles.order(created_at: :desc)
    render json: @motorcycles, status: :ok
  end

  def update_availability
    @motorcycle = current_user.motorcycles.find(params[:id])
    if @motorcycle.update(available: !@motorcycle.available)
      render json: { message: 'Availability updated successuflly', available: @motorcycle.available }
    else
      render json: { errors: @motorcycle.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def create
    @motorcycle = Motorcycle.new(motorcycle_params)
    if @motorcycle.save
      render json: { success: true, message: 'Motorcycle was created successfully', motorcycle: @motorcycle },
             status: :created
    else
      render json: { errors: @motorcycle.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @motorcycle.destroy
      render json: { success: true, message: 'Motorcycle was deleted ' }
    else
      render json: { errors: 'Failed to delete motorcycle' }, status: :unprocessable_entity
    end
  end

  private

  def motorcycle_params
    params.require(:motorcycle).permit(:make, :model, :year, :color, :license_plate, :image, :price)
  end

  def set_motorcycle
    @motorcycle = Motorcycle.find(params[:id])
  end

  def check_admin
    return if current_user.is?(:admin)

    render json: { errors: 'Unauthorized' }, status: :unauthorized
  end
end
