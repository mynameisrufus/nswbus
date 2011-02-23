class Stop < ActiveRecord::Base
  class Document < Nokogiri::XML::SAX::Document
    def start_element(name, attrs = [])
      attributes = Hash[attrs]
      case name
      when "Stop"
        @tsn = attributes["TSN"]
      when "Arrival"
        attributes["tsn"] = @tsn
        attributes["vehicleid"] = attributes.delete("vehicleID")
        attributes["realtime"] = attributes.delete("realTime")
        attributes["arrivaltime"] = Time.at(attributes.delete("arrivalTime").to_i)
        attributes["routename"] = attributes.delete("routeName")
        Stop.create(attributes)
      end
    end
  end

  belongs_to :stop_description, :foreign_key => "tsn", :primary_key => "tsn"
  has_one :vehicle, :foreign_key => "vehicleid", :primary_key => "vehicleid"

  def self.filename
    'stops.xml'
  end

  def route_colour
    case
    when self.routename =~ /m/i
      "#d40000"
    when self.routename =~ /l/i
      "#5555ff"
    else
      "#87cdde"
    end
  end
end
