class Crime < ActiveRecord::Base

  RESOURCE_ID = "d356a409-6764-46d7-942d-4d5a7ffb1c28"
  def self.import
    DataSaver.save_resources(RESOURCE_ID, "crimes")
  end

  def self.clean_data(data)
    # 
    data
  end

end
