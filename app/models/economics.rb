class Economic < ActiveRecord::Base
  RESOURCE_ID = 'bc4b4f54-ec69-4620-95ee-773d75f5460f'

  def self.import
    DataSaver.save_resources(RESOURCE_ID, 'economics')
  end
end
