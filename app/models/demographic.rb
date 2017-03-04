class Demographic < ActiveRecord::Base
  RESOURCE_ID = 'dbbec00e-87cc-4f9e-b029-97c161b08f60'

  def self.import
    DataSaver.save_resources(RESOURCE_ID, 'demographics')
  end

  def self.clean_data(data)
    #
    data
  end
end
