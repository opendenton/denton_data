class DeleteWellInspections < ActiveRecord::Migration[5.0]
  def up
    drop_table :well_inspections
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end