class StopDescriptionsController < ApplicationController
  respond_to :json

  def index
    @stop_descriptions = StopDescription.all
    respond_with @stop_descriptions
  end

  def show
    @stop_description = StopDescription.where(:tsn => params[:tsn]).first
    respond_with @stop_description
  end

  def search
    @stop_descriptions = StopDescription.search(params[:description])
    respond_with @stop_descriptions
  end
end
