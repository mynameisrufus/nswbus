class Position
  attr_accessor :latitude, :longitude
  alias :lat :latitude
  alias :long :longitude

  def initialize(latitude, longitude)
    @latitude  = latitude.to_f
    @longitude = longitude.to_f
  end
end
