class CreateVoterDistricts < ActiveRecord::Migration[5.0]
  def change
		create_table :voter_districts do |t|
			t.integer :_id
			t.integer :objectid
			t.string :name
			t.string :district_n
			t.integer :gid
			t.integer :total_ac
			t.integer :land_ac
			t.integer :t_can_ac
			t.integer :t_can_pct
			t.integer :veg_ac
			t.integer :veg_pct
			t.integer :bld_ac
			t.integer :bld_pct
			t.integer :to_ia_ac
			t.integer :to_ia_pct
			t.integer :road_ac
			t.integer :road_pct
			t.integer :plot_ac
			t.integer :plot_pct
			t.integer :swalk_ac
			t.integer :swalk_pct
			t.integer :ot_ia_ac
			t.integer :ot_ia_pct
			t.integer :wat_ac
			t.integer :wat_pct
			t.integer :soil_ac
			t.integer :soil_pct
			t.integer :utc_ac
			t.integer :utc_pct
			t.integer :ppa_v_ac
			t.integer :ppa_v_pct
			t.integer :to_ppa_ac
			t.integer :to_ppa_pct
			t.integer :ppa_ia_ac
			t.integer :ppa_ia_pct
			t.integer :un_ia_ac
			t.integer :un_ia_pct
			t.integer :to_un_ac
			t.integer :to_un_pct
			t.integer :un_sl_ac
			t.integer :un_sl_pct
			t.integer :un_ot_ac
			t.integer :un_ot_pct
			t.integer :shape__area
			t.integer :shape__length
		end
  end
end
