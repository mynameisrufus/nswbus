require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")
require File.expand_path(File.dirname(__FILE__) + "/../../bus/dlprocess")

task :download do
  download
end

task :xmlconvert do
  xmlconvert
end
