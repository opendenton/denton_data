# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170303231753) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "billboards", force: :cascade do |t|
    t.integer "_id"
    t.integer "x"
    t.integer "y"
    t.integer "objectid"
    t.integer "billboardid"
    t.string  "idbyowner"
    t.string  "owner"
    t.string  "parcelowner"
    t.string  "codsitus"
    t.string  "parcelid"
    t.string  "permitid"
    t.string  "zoningcode"
    t.string  "frontadvertisement"
    t.string  "rearadvertisement"
    t.integer "supportquantity"
    t.string  "supportmaterial"
    t.integer "lightquantity"
    t.string  "lighttype"
    t.string  "advertisementcorridor"
    t.integer "distancetorow"
    t.integer "estimatedheight"
    t.integer "latitude"
    t.integer "longitude"
  end

  create_table "denton_demographics", force: :cascade do |t|
    t.integer "_id"
    t.integer "year"
    t.string  "title_field"
    t.integer "value"
  end

  create_table "denton_houses", force: :cascade do |t|
    t.integer "year"
    t.integer "total_housing_units"
    t.integer "vacant_housing_units"
    t.integer "occupied_housing_units"
    t.integer "owner_occupied"
    t.integer "median_gross_rent"
    t.integer "renter_occupied"
  end

  create_table "schools", force: :cascade do |t|
    t.integer "_id"
    t.integer "objectid"
    t.integer "gis_nr_sde_schools_area"
    t.integer "perimeter"
    t.integer "poi_"
    t.integer "poi_id"
    t.integer "symbol"
    t.string  "school"
    t.string  "address"
    t.string  "type_of_school"
    t.integer "shapearea"
    t.integer "shapelen"
  end

  create_table "well_inspections", force: :cascade do |t|
    t.integer  "x"
    t.integer  "y"
    t.integer  "objectid"
    t.string   "sitetype"
    t.integer  "featureid"
    t.string   "trakitid"
    t.string   "propertyid"
    t.string   "siteaddres"
    t.string   "operator"
    t.string   "descriptio"
    t.string   "wellid"
    t.string   "status"
    t.string   "site"
    t.string   "rrcid"
    t.string   "platid"
    t.datetime "platdate"
    t.string   "amendedpla"
    t.datetime "amendedp_1"
    t.string   "roaddmgfee"
    t.datetime "feepaiddat"
    t.string   "invoicesta"
    t.datetime "invoices_1"
    t.string   "rrcpermit"
    t.datetime "rrcpermitd"
    t.datetime "casingdate"
    t.datetime "spudcompda"
    t.datetime "plugdate"
    t.string   "gaswelllocation"
    t.string   "zoningdistrict"
    t.string   "zoningcase"
    t.datetime "lastinspectiondate"
    t.string   "fullname"
    t.integer  "_id"
  end

end
