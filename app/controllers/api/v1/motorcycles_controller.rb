class Api::V1::MotorcyclesController < ApplicationController
  before_action :authorize_request
  def show
    @motorcycle = Motorcycle.find(params[:id])
    render json: @motorcycle
  end
end
