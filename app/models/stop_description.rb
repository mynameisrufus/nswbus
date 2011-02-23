class StopDescription < ActiveRecord::Base
  has_many :stops, :foreign_key => "tsn", :primary_key => "tsn"
  
  def self.xml
    'stopdescription.xml'
  end

  def self.update!(dir)
    file = File.join(dir, xml)
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
