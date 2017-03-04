require 'pg'
require 'sinatra/activerecord'
require 'active_support/all'
require_relative './data_importer'
require_relative './file_generator'

class DataSaver

  def self.save_all(resource_id, table_name)
    FileGenerator.generate_resource(resource_id, table_name)
    self.save_resources(resource_id, table_name)
  end

  def self.save_resources(resource_id, table_name)
    load File.join( File.dirname(__FILE__), "#{table_name.singularize}.rb")
    class_name = table_name.classify.constantize
    results = DataImporter.get_all(resource_id)
    results.each do |result|
      result = class_name.send(:clean_data, result)
      class_name.create(result)
    end
    nil
  end

  def self.save_sample_data(result, table_name)
    FileGenerator.generate_json(result)

    attributes = self.parse_attributes(result['fields'])
    FileGenerator.generate_migration(table_name, attributes)
  end

  private

    def self.parse_attributes(fields)
      attributes = {}
      fields.each do |field|
        attr_name = field["id"]
        data_type = FIELDS_MAP[field["type"].to_sym]
        attributes[attr_name] = data_type
      end
      attributes
    end

end
