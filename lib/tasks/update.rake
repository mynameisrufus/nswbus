require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")

namespace :download do
  task :every_day do
    Download.new do |downloader|
      downloader.stopdescriptions!
      downloader.update StopDescription
    end
  end
  
  task :every_minute do
    Download.new do |downloader|
      downloader.ptipslivedata!
      downloader.update Stop, Vehicle
    end
  end
end
