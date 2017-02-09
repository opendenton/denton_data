require 'httparty'
require 'date'
require 'ap'
require_relative './denton_data'

# NOTE: currently this will only return the first 100 records
# =>    this is a feature of CKan's API
# TODO: Support pulling in more than 100 records.                    (*done*)
# =>       - note: there is a "next" url returned from every call

class ImportGasInspection

  def self.import_well_inspection
    conn = DentonData.connection
    tld = "http://data.cityofdenton.com/api/action"
    offset = 0
    response = HTTParty.get("#{tld}/datastore_search\?offset\=#{offset}\&resource_id\=814a6238-8a8e-4ab9-9cbf-18288cdc5c38")
    total = response["result"]["total"].to_i

    records = []

    while offset <= total
      response = HTTParty.get("#{tld}/datastore_search\?offset\=#{offset}\&resource_id\=814a6238-8a8e-4ab9-9cbf-18288cdc5c38")
      response["result"]["records"].each do |record|
        record.select! do |k,v|
          v.strip != "" if v.kind_of?(String)
        end
        records << record
      end
      offset += 100
    end

    records.each do |rec|

      values = rec.keys.map do |key|
        if rec[key].kind_of?(String) && rec[key].strip.empty?
          ","
        else
          "\"#{rec[key]}\","
        end
      end
      query = %Q{
        INSERT INTO well_inspection VALUES (
          #{values.join.chomp}
        );
      }
      puts query
      conn.exec(query)
    end

  end
end

ImportGasInspection.import_well_inspection
