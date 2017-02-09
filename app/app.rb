require 'sinatra'
require_relative './models/denton_housing'
require "sinatra/activerecord"

set :database_file, "../config/database.yml"

get '/denton-housing' do
  DentonHousing.get_housing.to_json
end

get '/total-housing-units' do
  DentonHousing.total_housing_units(params["year"])
end

get '/vacant_housing_units' do
  DentonHousing.vacant_housing_units(params["year"])
end
