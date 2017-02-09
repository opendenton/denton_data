require 'json'
require "sinatra/activerecord"
require_relative './well_inspection'

class DataImporter

  def init
    save_objects
  end

  # for now get from data.json
  # eventually hit the API endpoint and
  # 1. parse headers to create table
  # 2. build migration
  # 3. run migration
  # 4. parse json for data array
  # 5. store json objs as ar instances
  def get_data
    null = nil

    data = File.read('/home/alexa/Desktop/projects/denton_data/data/data.json')
    JSON.parse(data)
  end

  def save_objects
    get_data.each do |inspection|
      WellInspection.create(inspection)
    end
  end


end
puts File.dirname(__FILE__)
d = DataImporter.new
d.init