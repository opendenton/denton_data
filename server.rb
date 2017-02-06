require 'sinatra'
require_relative './denton_housing'

get '/denton-housing' do
  DentonHousing.get_housing.to_json
end

get '/total-housing-units' do
  DentonHousing.total_housing_units(params["year"])
end

get '/vacant_housing_unit' do
  DentonHousing.vacant_housing_unit(params["year"])
end
