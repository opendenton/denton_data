class WellInspection < ActiveRecord::Base
  RESOURCE_ID = 'e8024ac8-ea92-4dc9-99f7-8d58de3e1473'

  def self.import
    DataSaver.save_resources(RESOURCE_ID, 'well_inspections')
  end
end
