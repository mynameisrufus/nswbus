# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Nswbus::Application.initialize!

LATLONG_OFFSET = 0.005 #500m, 1 km = 0.01 http://en.wikipedia.org/wiki/Decimal_degrees
