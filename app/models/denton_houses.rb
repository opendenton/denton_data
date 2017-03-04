class DentonHouse < ActiveRecord::Base
  RESOURCE_ID = '815db0db-9e6e-4c08-b516-80b9a2539142'

  def self.import
    response = DataImporter.fetch(RESOURCE_ID)

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

  def self.get_housing
    all.map do |house|
      house.attributes.except('id')
    end
  end

  def self.total_housing_units(year)
    return unless year
    where(year: year).map(&:total_housing_units)
  end

  def self.vacant_housing_units(year)
    return unless year
    where(year: year).map(&:vacant_housing_units)
  end

  def self.clean_data(data)
    data
  end
end
