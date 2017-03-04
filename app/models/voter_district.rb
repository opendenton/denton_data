require_relative './data_saver'

class VoterDistrict < ActiveRecord::Base

  RESOURCE_ID = "972accc0-0bf2-47f4-a44b-0ff5b663b9cb"
  def self.import
    DataSaver.save_resources(RESOURCE_ID, "voter_districts")
  end

  def self.clean_data(data)
    #
    data
  end

end
