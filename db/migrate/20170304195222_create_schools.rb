class CreateSchools < ActiveRecord::Migration[5.0]
  def change
		create_table :schools do |t|
			t.float :objectid
			t.float :gis_nr_sde_schools_area
			t.float :perimeter
			t.float :poi_
			t.float :poi_id
			t.float :symbol
			t.string :school
			t.string :address
			t.string :type_of_school
			t.float :shapearea
			t.float :shapelen
		end
  end
end
