class DentonHouse < ActiveRecord::Base
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
