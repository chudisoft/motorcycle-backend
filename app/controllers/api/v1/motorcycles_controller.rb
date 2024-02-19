class Api::V1::MotorcyclesController < ApplicationController
  before_action :authorize_request
  before_action :set_motorcycle, only: %i[show destroy]

  def index
    motorcycles = Motorcycle.all
    if motorcycles.empty?
      render json: { message: 'No motorcycles found', motorcycles: }
    else
      render json: { message: 'Motorcycles found', motorcycles: }
    end
  end

  def show
    @motorcycle = Motorcycle.find(params[:id])
    render json: @motorcycle
  end

  def destroy
    if @motorcycle.destroy
      render json: { success: true, message: 'Motorcycle was deleted ' }
    else
      render json: { error: true, message: 'Failed to delete motorcycle' }, status: :unprocessable_entity
    end
  end

  def set_motorcycle
    @motorcycle = Motorcycle.find(params[:id])
  end
end
