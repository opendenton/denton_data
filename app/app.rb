require 'json'
require 'sinatra'
require "sinatra/activerecord"
require 'uri'

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
	Crime.import
	GasWellInspection.import
	VoterDistrict.import
  Billboard.import
  School.import
  DentonHouse.import
  HomelessnessSurvey.import
  Demographic.import
  Economic.import
  "Data Imported"
end

###################
# Delete all data #
###################

get '/delete-data' do
	Crime.delete_all
	GasWellInspection.delete_all
	VoterDistrict.delete_all
  Billboard.delete_all
  School.delete_all
  DentonHouse.delete_all
  HomelessnessSurvey.destroy_all
  Demographic.destroy_all
  Economic.destroy_all
  "She's dead, Jim."
end

##########
# Home / #
##########

get '/' do
  "Endpoints here."
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

########################
# Homelessness Surveys #
########################

get '/homelessness-survey' do
  HomelessnessSurvey.all.map do |record|
    record.attributes.except('id')
  end.to_json
end

#######################
# Gas Well Inspection #
#######################

get '/gas-well-inspections' do
  GasWellInspection.all.select( 'id, x, y, siteaddres, fullname, lastinspectiondate, status' ).to_json
end

get '/gas-well-inspections/:id' do
  GasWellInspection.where(id: params[:id]).to_json
end

################
# Demographics #
################

get '/demographics' do
  Demographic.all.map do |record|
    record.attributes.except('id')
  end.to_json
end

get '/demographics/:year' do
  Demographic.where(year: params[:year]).each_with_object({}) do |demo, obj|
    obj[demo.title_field] = demo.value
  end.to_json
end

################
# Ecoomics #
################

get '/economics' do
  Economic.all.map do |record|
    record.attributes.except('id')
  end.to_json
end


###################
# Voter Districts #
###################

get '/voter-districts' do
  VoterDistrict.all.map do |record|
    record.attributes.except('id')
  end.to_json
end

#########
# Crime #
#########

get '/crimes' do
  Crime.pluck('crime').group_by do |crime|
    crime
  end.map do |key, value|
    data = Hash.new
    data[:violaton] = key
    data[:count] = value.count
    data[:url] = URI.encode("/crimes/violation/#{URI.encode(key)}")
    data
  end.sort_by do |hash|
    -hash[:count]
  end.to_json
end

get '/crimes/violation/:crime' do
  crime = URI.decode params[:crime]
  Crime.where(crime: crime).to_json
end
