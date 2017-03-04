class CreateCrimes < ActiveRecord::Migration[5.0]
  def change
		create_table :crimes do |t|
			t.integer :_id
			t.string :crime
			t.string :locname
			t.datetime :incidentdatetime
			t.string :publicadress
			t.string :agency
			t.string :accuracy
		end
  end
end
