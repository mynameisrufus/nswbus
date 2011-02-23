class StopDescription < ActiveRecord::Base
  class Document < Nokogiri::XML::SAX::Document
    def start_element(name, attrs)
      if name == "stop"
        attributes = Hash[attrs]
        attributes["tsn"] = attributes.delete("TSN")
        StopDescription.create(attributes)
      end
    end
  end

  has_many :stops, :foreign_key => "tsn", :primary_key => "tsn"

  def self.filename
    'stopdescription.xml'
  end
end
