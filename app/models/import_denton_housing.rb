require 'httparty'
require_relative './denton_data'

require 'ap'

class ImportDentonHousing

  def self.import_housing
    conn = DentonData.connection
    tld = "http://data.cityofdenton.com/api/action"
    response = HTTParty.get("#{tld}/datastore_search\?resource_id\=815db0db-9e6e-4c08-b516-80b9a2539142")

    ap response
    records = response["result"]["records"].reduce({}) do |accum, record|
      year = record.delete("year")
      accum[year] ||= {}
      accum[year][record['title_field']] = record['value']
      accum;
    end

    # ap records

    records.each do |year, rec|
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

ImportDentonHousing.import_housing
