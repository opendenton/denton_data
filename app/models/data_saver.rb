require 'pg'
require 'sinatra/activerecord'
require 'active_support/all'
require_relative './data_importer'
require_relative './well_inspection'

class DataSaver

  def self.save_resources(resource_id, table_name)
    class_name = table_name.classify.constantize
    results = DataImporter.get_all(resource_id)

    results.each do |result|
      class_name.create(result)
    end
    nil
  end

end