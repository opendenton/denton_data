require 'pg'
require 'sinatra/activerecord'
require 'active_support/all'
require_relative './data_importer'
require_relative './file_generator'
Dir["./*.rb"].each {|file| require file }

class DataSaver

  def self.save_all(resource_id, table_name)
    FileGenerator.generate_resource(resource_id, table_name)
    self.save_resources(resource_id, table_name)
  end

  def self.save_resources(resource_id, table_name)
    load File.join( File.dirname(__FILE__), "#{table_name.singularize}.rb")
    class_name = table_name.classify.constantize
    results = DataImporter.get_all(resource_id)
    # binding.pry
    results.each do |result|
      result = class_name.clean_data(result)
      class_name.create(result)
    end
    nil
  end

end