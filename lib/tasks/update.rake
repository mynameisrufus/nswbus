require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")

namespace :download do
  task :stops do
    Stop.download
  end

  task :vehicles do
    Vehicle.download
  end

  task :stop_descriptions do
    StopDescription.download
  end
end
