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
  
  def json_results
    JSON.parse(results) unless results.blank?
  end
  
  def plate_number
    json_results["results"].first["plate"] unless results.blank?
  end
  
  def save_alpr_scan(path_to_file)
    self.results = `alpr -j #{path_to_file}`
    self.save
  end
end
