class Vehicle < ActiveRecord::Base
  belongs_to :stop, :foreign_key => "vehicleid", :primary_key => "vehicleid"
  
  extend Importer
  
  def self.url
    'http://nswbusdata.info/ptipslivedata/getptipslivedata'
  end

  def self.zip
    'ptipslivedata'
  end

  def self.xml
    'vehicles'
  end

  def self.update(file)
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
