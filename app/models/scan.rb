class Scan < ActiveRecord::Base
  
  validates :file_url, :presence => true
  
  after_create :save_alpr_scan
  
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
  
  def save_alpr_scan
    require 'open-uri'
    
    uri = URI.parse(file_url)
    file = open(uri.to_s)
    begin
      self.results = `alpr -j #{file}`
      self.save
#      send_data file.read, :type => "image/jpeg", :disposition => "inline"
    ensure
      file.close
    end
  end
end
