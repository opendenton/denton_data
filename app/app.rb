require 'json'
require 'sinatra'
require "sinatra/activerecord"
require_relative './models/denton_houses'
require_relative './models/well_inspection'
require_relative './models/data_saver'
require_relative './models/demographics'
require_relative './models/economics'
require_relative './models/homelessness_survey'

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
  WellInspection.import
  DentonHouse.import
  HomelessnessSurvey.import
  Demographic.import
  Economic.import
end

###################
# Delete all data #
###################

get '/delete-data' do
  WellInspection.delete_all
  DentonHouse.delete_all
  HomelessnessSurvey.destroy_all
  Demographic.destroy_all
  Economic.destroy_all
end

#################
# Denton Houses #
#################

get '/denton-housing' do
  DentonHouse.get_housing.to_json

  #puts JSON.pretty_generate(DentonHouse.get_housing)
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
