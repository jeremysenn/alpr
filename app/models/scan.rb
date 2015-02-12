class Scan < ActiveRecord::Base
  
  def alpr_scan(path_to_file)
    self.results = `alpr -j #{path_to_file}`
    self.save
  end
end
