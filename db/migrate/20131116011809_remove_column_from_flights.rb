class RemoveColumnFromFlights < ActiveRecord::Migration
  def up
  	remove_column :flights, :plane_id
  end

  def down
  	add_column :flights, :plane_id, :integer
  end
end
