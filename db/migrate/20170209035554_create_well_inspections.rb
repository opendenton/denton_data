class CreateWellInspections < ActiveRecord::Migration[5.0]
  def change
    create_table :well_inspections do |t|
      t.integer :x
      t.integer :y
      t.integer :objectid
      t.string :sitetype
      t.integer :featureid
      t.string :trakitid
      t.string :propertyid
      t.string :siteaddres
      t.string :operator
      t.string :descriptio
      t.string :wellid
      t.string :status
      t.string :site
      t.string :rrcid
      t.string :platid
      t.datetime :platdate
      t.string :amendedpla
      t.datetime :amendedp_1
      t.string :roaddmgfee
      t.datetime :feepaiddat
      t.string :invoicesta
      t.datetime :invoices_1
      t.string :rrcpermit
      t.datetime :rrcpermitd
      t.datetime :casingdate
      t.datetime :spudcompda
      t.datetime :plugdate
      t.string :gaswelllocation
      t.string :zoningdistrict
      t.string :zoningcase
      t.datetime :lastinspectiondate
      t.string :fullname
    end
  end
end
