class Vehicle < ActiveRecord::Base
  class Document < Nokogiri::XML::SAX::Document
    def start_element(name, attrs = [])
      if name == "vehicle"
        attributes = Hash[attrs]
        match_data = attributes.delete("serviceDescription").match(/^([0-9]{2}:[0-9]{2}) - (.*)/)
        
        attributes["schedule"]           = match_data[1]
        attributes["servicedescription"] = match_data[2]
        attributes["vehicleid"]          = attributes.delete("vehicleID")
        attributes["tripstatus"]         = attributes.delete("tripStatus")
        attributes["routedirection"]     = attributes.delete("routeDirection")
        attributes["routevariant"]       = attributes.delete("routeVariant")
        attributes["routename"]          = attributes.delete("routeName")
        Vehicle.create(attributes)
      end
    end
  end

  belongs_to :stop, :foreign_key => "vehicleid", :primary_key => "vehicleid"
  
  def self.filename
    'vehicles.xml'
  end
end
