require 'json'
require_relative './denton_data'

class DentonHousing

  def self.get_housing
    conn = DentonData.connection
    records = conn.exec("SELECT * FROM denton_housing")
    records.map do |record|
      record.to_hash
    end
  end

  def self.total_housing_units(year)
    if year
      DentonData.connection.exec(
        "select total_housing_units from denton_housing where year = #{year};"
      )
    end
  end

  def self.vacant_housing_units(year)
    if year
      DentonData.connection.exec(
        "select vacant_housing_units from denton_housing where year = #{year};"
      )
    end
  end

end
