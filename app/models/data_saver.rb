require 'pg'
require 'sinatra/activerecord'
require 'active_support/all'
require_relative './data_importer'
require_relative './file_generator'

class DataSaver
  # As more datatypes are encountered, add to this hash
  FIELDS_MAP = {
    "int4": "integer",
    "numeric": "integer",
    "text": "string",
    "timestamp": "datetime"
  }

  def self.save_all(resource_id, table_name)
    FileGenerator.generate_model(table_name)
    self.save_resources(resource_id, table_name)
  end

  def self.save_resources(resource_id, table_name)
    class_name = table_name.classify.constantize
    results = DataImporter.get_all(resource_id)

    results.each do |result|
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