require 'json'
require 'sinatra'
require "sinatra/activerecord"

Dir["./app/models/*.rb"].each { |file| require file }

configure :production do
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
end

configure :development do
  set :database_file, "../config/database.yml"
end

after do
 ActiveRecord::Base.clear_active_connections!
end

###############################################
# Import all data
# - Add additional import methods to this route
###############################################

get '/import-data' do
  Billboard.import
  School.import
  DentonDemographic.import
  WellInspection.import
  ImportDentonHouse.import_housing
end

###################
# Delete all data #
###################

get '/delete-data' do
  Billboard.delete_all
  School.delete_all
  DentonDemographic.delete_all
  WellInspection.delete_all
  DentonHouse.delete_all
end

#################
# Denton Houses #
#################

get '/denton-housing' do
  DentonHouse.get_housing.to_json
end

get '/total-housing-units' do
  DentonHouse.total_housing_units(params["year"]).to_json
end

get '/vacant-housing-units' do
  DentonHouse.vacant_housing_units(params["year"]).to_json
end

###################
# Well Inspection #
###################

get '/' do
  time = Time.now
  inspections = WellInspection.order(objectid: :asc)
  "Number of entries: #{inspections.count}<br>#{inspections.map { |i| i.objectid }}!"
end

get '/' do
  time = Time.now
  inspections = WellInspection.all
  "#{inspections.map { |i| i.operator }}!"
end
