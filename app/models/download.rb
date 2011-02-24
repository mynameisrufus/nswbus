require 'open-uri'
require 'zip/zip'

class Download
  @@uri             = 'http://nswbusdata.info/ptipslivedata/getptipslivedata'
  @@ptipslivedata   = 'ptipslivedata.zip'
  @@stopdescription = 'stopdescriptions.zip'
  
  def initialize
    yield self if block_given?
  end

  def ptipslivedata!
    download(@@ptipslivedata)
  end

  def stopdescriptions!
    download(@@stopdescription)
  end

  def temp_dir
    File.expand_path(File.join(::Rails.root,"/tmp"))
  end

  def time
    Time.now.strftime('%F-%H-%M-%S')
  end

  def download(zip)
    @dir = File.join(temp_dir, time)
    FileUtils.mkdir_p @dir
    zip_path = File.join(@dir, zip)
    begin
      out = open(zip_path, 'wb')
      out.write(open("#{@@uri}?filename=#{zip}").read)
      out.close
    rescue Timeout::Error => e
      STDERR.puts "Could not download #{zip} from #{@@uri} - #{e.to_s}"
      exit
    end
    Zip::ZipFile.open(zip_path) do |file|
      file.each do |e|
        file.extract(e, File.join(@dir, e.name))
      end
    end
    @dir
  end

  def update(*model_classi)
    ActiveRecord::Base.transaction do
      model_classi.each do |model_class|
        model_class.truncate
        File.open(File.join(@dir, model_class.filename)) do |file|
          Nokogiri::XML::SAX::Parser.new(model_class::Document.new).parse(file)
        end
      end
    end
  end
end
