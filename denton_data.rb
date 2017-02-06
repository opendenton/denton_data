require 'pg'

class DentonData
  def self.connection
    conn = PG.connect(
      :dbname => 'denton_data',
      :user => 'denton_data',
      :password => 'password1'
    )
  end
end
