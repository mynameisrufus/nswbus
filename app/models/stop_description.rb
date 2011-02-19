class StopDescription < ActiveRecord::Base
  has_many :stops, :foreign_key => "tsn", :primary_key => "tsn"

  extend Importer
  
  def self.url
    'http://nswbusdata.info/ptipslivedata/getptipslivedata'
  end

  def self.zip
    'stopdescriptions'
  end

  def self.xml
    'stopdescription'
  end

  def self.update(file)
    xml = Nokogiri.parse(File.read(file))
    transaction do
      connection.execute("TRUNCATE TABLE #{table_name};")
      xpath = xml.xpath('//stop')
      xpath.each do |element|
        attrs = {}
        element.each do |a|
          attrs.merge! a.first.downcase.to_sym => (a.last == "" ? nil : a.last)
        end
        create! attrs
      end
    end
  end
end
