class Position
  attr_accessor :latitude, :longitude
  alias :latitude :lat
  alias :longitude :long

  def initialize(latitude, longitude)
    @latitude  = latitude.to_f
    @longitude = longitude.to_f
  end
end
