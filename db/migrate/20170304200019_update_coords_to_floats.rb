class UpdateCoordsToFloats < ActiveRecord::Migration[5.0]
  def change
    change_column :gas_well_inspections, :x, :float
    change_column :gas_well_inspections, :y, :float
  end
end
