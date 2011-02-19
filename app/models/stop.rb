class Stop < ActiveRecord::Base
  has_many :vehicles, :foreign_key => "vehicleid"

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
      xpath = xml.xpath('//Stop')
      xpath.each do |element|
        tsn = element.attribute('TSN').value
        element.children.each do |list|
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
