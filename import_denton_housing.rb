require 'httparty'
require 'json'
require 'ap'
require_relative './denton_data'

class ImportDentonHousing

  def self.import_housing
    conn = DentonData.connection
    tld = "http://data.cityofdenton.com/api/action"
    response = HTTParty.get("#{tld}/datastore_search\?resource_id\=815db0db-9e6e-4c08-b516-80b9a2539142")
    records = response["result"]["records"].reduce({}) do |accum, record|
      year = record.delete("year")
      accum[year] ||= {}
      accum[year][record['title_field']] = record['value']
      accum;
    end

    records.each do |year, rec|
      conn = PG.connect(
        :dbname => 'denton_data',
        :user => 'denton_data',
        :password => 'password1'
      )

      conn.exec %Q{
        INSERT INTO denton_housing VALUES(
          #{year},
          #{rec["Total Housing Units"]},
          #{rec["Vacant Housing Units"]},
          #{rec["Occupied Housing Units"]},
          #{rec["Owner Occupied"]},
          #{rec["Renter Occupied"]},
          #{rec["Median Gross Rent"]}
        )
      }
    end
  end

end

DentonHousing.import_housing


#  [0] "Total Housing Units",
#  [1] "Vacant Housing Units",
#  [2] "Occupied Housing Units",
#  [3] "Owner Occupied",
#  [4] "Renter Occupied",
#  [5] "Median Gross Rent"
#
#
#
#{
#   "_id" => 1,
#   "title_field" => "Total Housing Units",
#   "value" => "49109",
#   "year" => "2014"
#}


