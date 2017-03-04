class UpdateCoordsToFloats < ActiveRecord::Migration[5.0]
  def change
    add_column :schools, :_id, :integer
  end
end
