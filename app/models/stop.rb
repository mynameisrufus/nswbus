class Stop < ActiveRecord::Base
  belongs_to :stop_description, :foreign_key => "tsn", :primary_key => "tsn"
  has_one :vehicle, :foreign_key => "vehicleid", :primary_key => "vehicleid"

  def self.xml
    'stops.xml'
  end
  
  def self.update!(dir)
    file = File.join(dir, xml)
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
