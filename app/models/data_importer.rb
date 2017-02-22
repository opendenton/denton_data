require 'json'
require 'httparty'
require 'ap'
require_relative './hash'

class DataImporter

  DATA_DIR = File.join(File.dirname(__FILE__), '../../data')
  TLD = "http://data.cityofdenton.com/api/action"

  def self.get_sampling(resource_id, limit=25)
    response = HTTParty.get("#{TLD}/datastore_search\?resource_id\=#{resource_id}&limit=#{limit}")
    result = response['result']

    self.save_sample_data(result)
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

    def self.save_sample_data(result)
      file_name = DATA_DIR + '/temp_data_' + self.current_time + '.json'
      File.open(file_name, 'w+') { |f| f.write JSON.pretty_generate(result) }
    end

    def self.current_time
      timestamp = Time.now.strftime('%s')
    end

end
