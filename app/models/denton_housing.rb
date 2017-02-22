require 'json'
require_relative './denton_data'

class DentonHousing < ActiveRecord::Base
  def self.get_housing
    conn = ActiveRecord::Base.connection
    records = conn.execute("SELECT * FROM denton_housing")
    records.map do |record|
      record.to_hash
    end
  end

  def self.total_housing_units(year)
    if year
      ActiveRecord::Base.connection.execute(
        "select total_housing_units from denton_housing where year = #{year};"
      )
    end
  end

  def self.vacant_housing_units(year)
    if year
      ActiveRecord::Base.connection.execute(
        "select vacant_housing_units from denton_housing where year = #{year};"
      )
    end
  end

end
