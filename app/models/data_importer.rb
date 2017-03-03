require 'json'
require 'httparty'
require 'ap'
require_relative './hash'
require_relative './file_generator'

class DataImporter

  TLD = "http://data.cityofdenton.com/api/action"

  def self.get_sampling(resource_id, table_name, limit=25)
    response = HTTParty.get("#{TLD}/datastore_search\?resource_id\=#{resource_id}&limit=#{limit}")
    result = response['result']
    # ap result
    # DataSaver.save_sample_data(result, table_name)
    FileGenerator.generate_initial(resource_id, table_name, result)
  end

  def self.get_all(resource_id)
    offset = 0
    response = self.get_page(resource_id, offset)
    total = response["result"]["total"].to_i
    records = response["result"]["records"]

    while offset <= total
      offset += 100
      response = self.get_page(resource_id, offset)
      records += response["result"]["records"]
    end

    records.map(&:downcase_key)
  end

  private 
    def self.get_page(resource_id, offset)
      HTTParty.get("#{TLD}/datastore_search\?offset\=#{offset}\&resource_id\=#{resource_id}")
    end

end