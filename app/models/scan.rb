class Scan < ActiveRecord::Base
  
  #############################
  #     Class Methods         #
  #############################
  
  def self.alpr_scan(path_to_file)
    JSON.parse(`alpr -j #{path_to_file}`)
  end
  
  #############################
  #     Instance Methods      #
  #############################
  
  def plate_number
    results["results"].first["plate"] unless results.blank
  end
  
  def save_alpr_scan(path_to_file)
    self.results = JSON.parse(`alpr -j #{path_to_file}`)
    self.save
  end
end
