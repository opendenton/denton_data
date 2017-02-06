require 'sinatra'
require_relative './denton_housing'

get '/denton-housing' do
  DentonHousing.get_housing.to_json
end
