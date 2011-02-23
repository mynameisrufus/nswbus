class Vehicle < ActiveRecord::Base
  belongs_to :stop, :foreign_key => "vehicleid", :primary_key => "vehicleid"
  
  def self.xml
    'vehicles.xml'
  end

  def self.update!(dir)
    file = File.join(dir, xml)
    xml = Nokogiri.parse(File.read(file))
    transaction do
      connection.execute("TRUNCATE TABLE #{table_name};")
      xpath = xml.xpath('//vehicle')
      xpath.each do |element|
        attrs = {}
        element.each do |a|
          attrs.merge! a.first.downcase.to_sym => (a.last == "" ? nil : a.last)
        end
        create! attrs
      end
    end
  end

  def colour

  end
end
