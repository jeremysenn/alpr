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
    
    file_extension = File.extname(file_url)
    temp_file = Tempfile.new(['', file_extension])
    temp_file.binmode # Must be in binary mode since we're creating an image file
    temp_file.write open(file_url).read
    temp_file.rewind
    begin
      self.results = `alpr -j #{temp_file.path}`
      self.save
    ensure
      temp_file.close
      temp_file.unlink   # deletes the temp file
    end
    
#    uri = URI.parse(file_url)
#    file = open(uri.to_s)
#    begin
#      self.results = `alpr -j #{file.path}`
#      self.save
##      send_data file.read, :type => "image/jpeg", :disposition => "inline"
#    ensure
#      file.close
#      file.unlink   # deletes the temp file
#    end
  end
end
