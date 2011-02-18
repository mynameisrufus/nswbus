#!/usr/bin/env ruby
# XML xpath selected elements to CSV for importing into a DB

require 'rubygems'
require 'nokogiri'
require 'fastercsv'
require 'activesupport' #Time.parse

URL='http://nswbusdata.info/ptipslivedata/getptipslivedata?filename=ptipslivedata.zip'

def download(time, url=URL)
  puts time
  `mkdir -p #{time}/`
  `wget #{url} -O #{time}/ptips.zip`
  `unzip #{time}/ptips.zip -d #{time}`
end

def xmlconvert(file)
  return nil unless File.exists? file
  filename = file.split('.')[0]
  sqlfile = filename + '.sql'
  xml = Nokogiri.parse(File.read(file))
  File.open(sqlfile, 'w') do |f|
    f.puts 'COPY ' + filename.split('/')[1] + ' FROM STDIN WITH CSV HEADER;'
  end
  FasterCSV.open(sqlfile, 'a', :force_quotes => true) do |csv|
    if file =~ /vehicles/
      xpath = xml.xpath('//vehicle')
      puts xpath.length
      csv.add_row xpath.first.map {|name, val| name.downcase} #Header
      xpath.each do |element|
        attrs = element.map { |name, val| val == "" ? "NULL" : val }
        csv.add_row(attrs)
      end
    elsif file =~ /stops/
      headers = xml.xpath('//Arrival').first.map {|name, val| name.downcase} #Header
      headers.unshift "tsn"
      csv.add_row headers
      stops = xml.xpath('//Stop')
      stops.each do |stop|
        tsn = stop.attribute('TSN').value
        stop.children.each do |list|
          list.children.each do |arr|
            attrs = arr.map { |name, val| val == "" ? "0" : val }
            attrs.unshift tsn
            arrtime = Time.at(attrs[5].to_i)
            attrs[5] = arrtime.to_s #('%F %H:%M:%S')
            csv.add_row(attrs)
          end
        end
      end
    end
  end
  `psql a4nbuses < #{filename + '.sql'}`
end

#import(ARGV[0], '//stop')
time = Time.now.strftime('%F-%H-%M')
download(time)
Dir.glob(File.join(time, '*.xml')).each do |file|
  puts file
  xmlconvert(file)
end
