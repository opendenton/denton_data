class School < ActiveRecord::Base

  RESOURCE_ID = "cebe500f-6324-441a-b1ef-b135fde4456e"
  def self.import
    DataSaver.save_resources(RESOURCE_ID, "schools")
  end

  def self.clean_data(data)
    data.delete 'id'
    data["type_of_school"] = data['type']
    data.delete 'type'
    data
  end

end
