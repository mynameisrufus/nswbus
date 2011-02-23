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
end
