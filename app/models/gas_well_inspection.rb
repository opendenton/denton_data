class GasWellInspection < ActiveRecord::Base

  RESOURCE_ID = "7a15190d-e0a6-4199-826b-33810ad47e9e"
  def self.import
    DataSaver.save_resources(RESOURCE_ID, "gas_well_inspections")
  end

  def self.clean_data(data)
    # 
    data
  end

end
