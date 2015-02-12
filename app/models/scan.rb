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
    uri = URI.parse(file_url)
    file = open(uri)
    begin
      self.results = `alpr -j #{file}`
      self.save
#      send_data file.read, :type => "image/jpeg", :disposition => "inline"
    ensure
      file.close
    end
  end
end
