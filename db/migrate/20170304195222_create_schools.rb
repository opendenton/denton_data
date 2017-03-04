class CreateSchools < ActiveRecord::Migration[5.0]
  def change
		create_table :schools do |t|
			t.integer :objectid
			t.float :gis_nr_sde_schools_area
			t.float :perimeter
			t.integer :poi_
			t.integer :poi_id
			t.integer :symbol
			t.string :school
			t.string :address
			t.string :type_of_school
			t.float :shapearea
			t.float :shapelen
		end
  end
end
