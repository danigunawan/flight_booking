class AddColumnToPlane < ActiveRecord::Migration
  def up
  	add_column :planes, :flight_id, :integer
  end

  def down
  	remove_column :planes, :flight_id
  end
end
