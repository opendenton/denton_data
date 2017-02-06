require 'ap'
require 'pg'

class DentonData
  def self.connection
    begin
      conn = PG.connect(
        :dbname => 'denton_data',
        :user => 'denton_data',
        :password => 'password1'
      )
    rescue PG::Error => e
      puts e.message
    ensure
      conn.close if conn
    end
  end
end
