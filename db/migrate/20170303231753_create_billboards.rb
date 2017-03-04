class CreateBillboards < ActiveRecord::Migration[5.0]
  def change
		create_table :billboards do |t|
			t.integer :_id
			t.integer :x
			t.integer :y
			t.integer :objectid
			t.integer :billboardid
			t.string :idbyowner
			t.string :owner
			t.string :parcelowner
			t.string :codsitus
			t.string :parcelid
			t.string :permitid
			t.string :zoningcode
			t.string :frontadvertisement
			t.string :rearadvertisement
			t.integer :supportquantity
			t.string :supportmaterial
			t.integer :lightquantity
			t.string :lighttype
			t.string :advertisementcorridor
			t.integer :distancetorow
			t.integer :estimatedheight
			t.integer :latitude
			t.integer :longitude
end
  end
end
