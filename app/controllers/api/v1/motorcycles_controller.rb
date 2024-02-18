class Api::V1::MotorcyclesController < ApplicationController
  def show
    @motorcycle = Motorcycle.find(params[:id])
    render json: @motorcycle
  end
end
