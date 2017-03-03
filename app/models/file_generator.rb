require 'fileutils'
require 'active_support/all'

class FileGenerator
  MIGRATION_DIR = File.join( File.dirname(__FILE__), "./../../db/migrate")
  MODEL_DIR = File.join(File.dirname(__FILE__), './../../app/models')
  DATA_DIR = File.join(File.dirname(__FILE__), './../../data')
  APP_DIR = File.join(File.dirname(__FILE__), './../../app')
  APP_PATH = File.join(File.dirname(__FILE__), './../../app/app.rb')
  # As more datatypes are encountered, add to this hash
  FIELDS_MAP = {
    "int4": "integer",
    "numeric": "integer",
    "text": "string",
    "timestamp": "datetime"
  }



  def self.generate_json(data)
    file_name = DATA_DIR + '/temp_data_' + self.current_time + '.json'
    File.open(file_name, 'w+') { |f| f.write JSON.pretty_generate(data) }
  end

  def self.generate_migration(table_name, attributes)
    system("rake db:create_migration NAME=create_#{table_name}")
    
    migration_file = Dir["#{MIGRATION_DIR}/*.rb"].select { |f| f =~ /#{table_name}/i }[0]
    tempfile = File.open("#{MIGRATION_DIR}/file.tmp", "w")
    original = File.new(migration_file)

    original.each do |line|
      tempfile << line
      if line.downcase =~ /def change/
        tempfile << "create_table :#{table_name} do |t|\n"
        attributes.each do |attribute_name, data_type|
          tempfile << "\t\tt.#{data_type} :#{attribute_name}\n"
        end
        tempfile << "end\n"
      end
    end

    original.close
    tempfile.close
    FileUtils.mv "#{MIGRATION_DIR}/file.tmp", migration_file
  end

  def self.generate_resource(resource_id, table_name)
    # self.generate_model(resource_id, table_name)
    system('rake db:migrate')
    self.insert_routes(table_name)
  end

  def self.generate_model(resource_id, table_name)
    # if system('rake db:migrate')
      model_file = File.open("#{MODEL_DIR}/#{table_name.singularize}.rb", "w")
      model_file << model_file_template(resource_id, table_name)
      model_file.close
    # end
  end

  def self.insert_routes(table_name)
    self.insert_import_and_delete(table_name)
  end

  def self.generate_initial(resource_id, table_name, result)
    self.generate_json(result)

    attributes = self.parse_attributes(result['fields'])
    self.generate_migration(table_name, attributes)
    self.generate_model(resource_id, table_name)
  end

  private

    def self.parse_attributes(fields)
      attributes = {}
      fields.each do |field|
        attr_name = field["id"].downcase
        data_type = FIELDS_MAP[field["type"].to_sym]
        attributes[attr_name] = data_type
      end
      attributes
    end

    def self.current_time
      timestamp = Time.now.strftime('%s')
    end

    def self.model_file_template(resource_id, table_name)
      <<-MODEL.strip_heredoc
        class #{ table_name.classify } < ActiveRecord::Base

          RESOURCE_ID = "#{resource_id}"
          def self.import
            DataSaver.save_resources(RESOURCE_ID, "#{table_name}")
          end

          def self.clean_data(data)
            # 
            data
          end

        end
        MODEL
    end

    def self.insert_import_and_delete(table_name)
      tempfile = File.open("#{APP_DIR}/file.tmp", "w")
      app_rb = File.open(APP_PATH)
      app_rb.each do |line|
        tempfile << line
        if line =~ /get '\/import-data' do/
          tempfile << "\t#{table_name.classify}.import\n"
        end
        if line =~ /get '\/delete-data' do/
          tempfile << "\t#{table_name.classify}.delete_all\n"
        end
      end

      tempfile.close
      app_rb.close
      FileUtils.mv "#{APP_DIR}/file.tmp", APP_PATH
    end
    

end