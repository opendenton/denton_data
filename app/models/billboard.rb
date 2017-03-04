class Billboard < ActiveRecord::Base

  RESOURCE_ID = "267f02e4-0dd9-4a0b-ab54-8fb05d4077fe"
  def self.import
    DataSaver.save_resources(RESOURCE_ID, "billboards")
  end

  def self.clean_data(data)
    # 
    data
  end

end
