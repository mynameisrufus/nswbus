module Importer
  def temp_dir
    File.expand_path(File.join(::Rails.root,"/tmp"))
  end

  def time
    Time.now.strftime('%F-%H-%M-%S')
  end

  def download
    dir = File.join(temp_dir, time)
    `mkdir -p #{dir}/`
    `wget #{url}?filename=#{zip}.zip -O #{dir}/#{zip}.zip`
    `unzip #{dir}/#{zip} -d #{dir}`
    update("#{dir}/#{xml}.xml")
  end
end
