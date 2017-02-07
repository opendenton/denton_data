require 'csv'
require 'json'

body = File.read('/Users/dm/Documents/dev/openDenton/denton_data/tests/Gas_Wells__Inspections_Layer.csv')

csv = CSV.new(body, :headers => true, :header_converters => :symbol, :converters => :all)
data = csv.to_a.map {|row| row.to_hash }

File.open('data.json', 'w+') { |f| f.write data.to_json }
