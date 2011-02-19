class Stop < ActiveRecord::Base
  extend Importer

  def self.url
    'http://nswbusdata.info/ptipslivedata/getptipslivedata'
  end

  def self.zip
    'ptipslivedata'
  end

  def self.xml
    'stops'
  end
  
  def self.update(file)
    xml = Nokogiri.parse(File.read(file))
    transaction do
      connection.execute("TRUNCATE TABLE #{table_name};")
      headers = xml.xpath('//Arrival').first.map {|name, val| name.downcase} #Header
      headers.unshift "tsn"
      stops = xml.xpath('//Stop')
      stops.each do |stop|
        tsn = stop.attribute('TSN').value
        stop.children.each do |list|
          list.children.each do |arr|
            attrs = {}
            arr.each do |a|
              attrs.merge! a.first.downcase.to_sym => (a.last == "" ? nil : a.last)
            end
            attrs.merge! :tsn => tsn
            attrs[:arrivaltime] = Time.at(attrs[:arrivaltime].to_i) unless attrs[:arrivaltime].nil?
            create! attrs
          end
        end
      end
    end
  end
end
