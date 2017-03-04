class DeleteDentonDemographic < ActiveRecord::Migration[5.0]
   def up
     drop_table :denton_demographics
   end

   def down
     raise ActiveRecord::IrreversibleMigration
   end
 end