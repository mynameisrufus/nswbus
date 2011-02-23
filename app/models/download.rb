class Download
  @@uri             = 'http://nswbusdata.info/ptipslivedata/getptipslivedata'
  @@ptipslivedata   = 'ptipslivedata.zip'
  @@stopdescription = 'stopdescriptions.zip'
  
  def self.ptipslivedata!
    download(@@ptipslivedata)
  end

  def self.stopdescriptions!
    download(@@stopdescription)
  end

  def self.temp_dir
    File.expand_path(File.join(::Rails.root,"/tmp"))
  end

  def self.time
    Time.now.strftime('%F-%H-%M-%S')
  end

  def self.download(zip)
    dir = File.join(temp_dir, time)
    `mkdir -p #{dir}/`
    `wget #{@@uri}?filename=#{zip} -O #{dir}/#{zip}`
    `unzip #{dir}/#{zip} -d #{dir}`
    dir
  end

  def self.update(dir)
    ActiveRecord::Base.transaction do
      [StopDescription, Stop, Vehicle].each do |model_class|
        model_class.truncate
        File.open(File.join(dir, model_class.filename)) do |file|
          Nokogiri::XML::SAX::Parser.new(model_class::Document.new).parse(file)
        end
      end
    end
  end
end
