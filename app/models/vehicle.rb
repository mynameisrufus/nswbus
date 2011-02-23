class Vehicle < ActiveRecord::Base
  class Document < Nokogiri::XML::SAX::Document
    def initialize
    end

    def start_element(name, attrs = [])
      if name == "vehicle"
        attributes = Hash[attrs]
        attributes["tsn"] = attributes.delete("TSN")
        StopDescription.create(attributes)
      end
    end
  end

  belongs_to :stop, :foreign_key => "vehicleid", :primary_key => "vehicleid"
  
  def self.filename
    'vehicles.xml'
  end

  def colour

  end
end
