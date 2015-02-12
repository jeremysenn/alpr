class Scan < ActiveRecord::Base
  
  def alpr_scan(path_to_file)
    JSON.parse(`alpr -j #{path_to_file}`)
  end
  
  def plate_number
    results["results"].first["plate"] unless results.blank
  end
  
  def save_alpr_scan(path_to_file)
    self.results = JSON.parse(`alpr -j #{path_to_file}`)
    self.save
  end
end
