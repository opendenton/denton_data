class HorseTail < ActiveRecord::Base
  RESOURCE_ID = "123-asdf"
  def self.import
    DataSaver.save_resources(RESOURCE_ID, "horse_tails"")
  end

end
