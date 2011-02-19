class Array
  def lat
    self.first
  end
  def long
    self.last
  end
end

class StopController < ApplicationController
  def index
    @stops = StopDescription.limit(10)
  end

  def search
    name = params[:search]
    @stops = StopDescription.where("tsndescription like ?", "%#{name}%")
    render :stops
  end

  def in_region()
    bounds = region(latlong)
    # NOTE Southern Hemisphere -33 lat, opposite comparator for negative
    @stops = StopDescription.where("latitude  > ?", bounds[0].lat).
                              where("longitude > ?", bounds[0].long).
                              where("latitude  < ?", bounds[1].lat).
                              where("longitude < ?", bounds[1].long).
                              limit(10)
    render :stops
  end

  def show()
    tsn = params[:id]
    @arrivals = Stop.includes(:vehicles).where("tsn = ?", tsn)
    @stop = StopDescription.where("tsn = ?", tsn).first
    render :show
  end

  private
  def region(latlong)
    return [[latlong.lat - LATLONG_OFFSET, latlong.long - LATLONG_OFFSET],
            [latlong.lat + LATLONG_OFFSET, latlong.long + LATLONG_OFFSET]]
  end

  def latlong
    if params[:lat].present? && params[:long].present?
      session[:latlong] = [params[:lat].to_f, params[:long].to_f]
      session[:latlong]
    elsif session[:latlong].present?
      session[:latlong]
    end
  end
end
