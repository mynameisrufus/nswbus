class StopDescription < ActiveRecord::Base
  class Document < Nokogiri::XML::SAX::Document
    def start_element(name, attrs)
      if name == "stop"
        attrs.each do |a|
          a.first.downcase!
        end
        StopDescription.create(Hash[attrs])
      end
    end
  end

  has_many :stops, :foreign_key => "tsn", :primary_key => "tsn"

  def self.filename
    'stopdescription.xml'
  end
end
