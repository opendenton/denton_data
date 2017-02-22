require 'sinatra'
require_relative './models/denton_housing'
require "sinatra/activerecord"
require_relative './models/well_inspection'

configure :production do
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
end

configure :development do
  set :database_file, "../config/database.yml"
end

get '/denton-housing' do
  DentonHousing.get_housing.to_json
end

get '/total-housing-units' do
  DentonHousing.total_housing_units(params["year"])
end

get '/vacant_housing_units' do
  DentonHousing.vacant_housing_units(params["year"])
end

get '/' do
  # WellInspection.delete_all
  time = Time.now
  inspections = WellInspection.order(objectid: :asc)
  "Number of entries: #{inspections.count}<br>#{inspections.map { |i| i.objectid }}!"
end

# Well Inspection Layers

# get '/well_inspections' do
#   DentonHousing.vacant_housing_units(params["year"])
# end
