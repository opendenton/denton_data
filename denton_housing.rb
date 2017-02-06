require 'httparty'
require 'json'
require 'ap'
require_relative './denton_data'

class DentonHousing

  def self.get_housing
    conn = DentonData.connection
    conn = PG.connect(
      :dbname => 'denton_data',
      :user => 'denton_data',
      :password => 'password1'
    )
    records = conn.exec("SELECT * FROM denton_housing")
    records.map do |record|
      record.to_hash
    end
  end

end

DentonHousing.get_housing
