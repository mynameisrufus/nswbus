require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")

namespace :download do
  task :every_day do
    dir = Download.stopdescriptions!
    StopDescription.update!(dir)
  end
  
  task :every_minute do
    dir = Download.ptipslivedata!
    Stop.update!(dir)
    Vehicle.update!(dir)
  end
end
