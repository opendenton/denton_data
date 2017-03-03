class CreateSchools < ActiveRecord::Migration[5.0]
  def change
create_table :schools do |t|
    t.integer :_id
    t.integer :objectid
    t.integer :gis_nr_sde_schools_area
    t.integer :perimeter
    t.integer :poi_
    t.integer :poi_id
    t.integer :symbol
    t.string :school
    t.string :address
    t.string :type_of_school
    t.integer :shapearea
    t.integer :shapelen
end
  end
end
