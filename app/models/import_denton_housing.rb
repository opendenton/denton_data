require 'httparty'

class ImportDentonHouse
  def self.import_housing
    tld = "http://data.cityofdenton.com/api/action"
    response = HTTParty.get("#{tld}/datastore_search\?resource_id\=815db0db-9e6e-4c08-b516-80b9a2539142")

    records = response["result"]["records"].reduce({}) do |accum, record|
      year = record.delete("year")
      accum[year] ||= {}
      accum[year][record['title_field']] = record['value']
      accum;
    end

    records.each do |year, rec|
      DentonHouse.create!(
        year: year,
        total_housing_units: rec["Total Housing Units"],
        vacant_housing_units: rec["Vacant Housing Units"],
        occupied_housing_units: rec["Occupied Housing Units"],
        owner_occupied: rec["Owner Occupied"],
        median_gross_rent: rec["Median Gross Rent"],
        renter_occupied: rec["Renter Occupied"],
      )
    end
  end
end
