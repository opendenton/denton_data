class HomelessnessSurvey < ActiveRecord::Base
  RESOURCE_ID = 'd9956b77-684e-45b0-bb53-8ed5be022b5e'

  def self.import
    DataSaver.save_resources(RESOURCE_ID, 'homelessness_surveys')
  end

  def self.clean_data(data)
    #
    data
  end
end
