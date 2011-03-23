class VehiclesController < ApplicationController
  respond_to :json

  def index
    @vehicles = Vehicle.all
    respond_with @vehicles
  end

  def show
    @vehicle = Vehicle.where(:routename => params[:routename])
    respond_with @vehicle
  end
end
