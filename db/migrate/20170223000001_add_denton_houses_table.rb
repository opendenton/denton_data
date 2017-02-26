class AddDentonHousesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :denton_houses do |t|
      t.integer :year
      t.integer :total_housing_units
      t.integer :vacant_housing_units
      t.integer :occupied_housing_units
      t.integer :owner_occupied
      t.integer :median_gross_rent
      t.integer :renter_occupied
    end
  end
end
