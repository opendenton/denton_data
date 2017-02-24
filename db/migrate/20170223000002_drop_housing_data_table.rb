class DropHousingDataTable < ActiveRecord::Migration[5.0]
  def change
    if ActiveRecord::Base.connection.data_source_exists?(:denton_housing)
      drop_table :denton_housing
    end
  end
end
