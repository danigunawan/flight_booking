class AddAgentIdColumnToReservations < ActiveRecord::Migration
  def up
  	add_column :reservations, :agent_id, :integer
  end
  def down
  	remove_column :reservations, :agent_id
  end
end
