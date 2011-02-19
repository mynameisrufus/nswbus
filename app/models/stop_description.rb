class StopDescription < ActiveRecord::Base
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
      #create!
    end
  end
end
