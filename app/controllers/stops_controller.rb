class StopsController < ApplicationController
  respond_to :json

  def index
    @stops = Stop.all
    respond_with @stops
  end

  def show
    @stop = Stop.where(:tsn => params[:tsn])
    respond_with @stop
  end

  def routename
    @stops = Stop.where(:routename => params[:routename]).all
    respond_with @stops
  end

  def destination
    @stops = Stop.search(params[:destination])
    respond_with @stops
  end
end
