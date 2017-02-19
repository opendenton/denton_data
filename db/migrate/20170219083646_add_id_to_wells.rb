class AddIdToWells < ActiveRecord::Migration[5.0]
  def change
    add_column :well_inspections, :_id, :integer
  end
end
