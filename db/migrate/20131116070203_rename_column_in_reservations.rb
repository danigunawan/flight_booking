class RenameColumnInReservations < ActiveRecord::Migration
  def up
  	rename_column :reservations, :frequentflier_id, :frequent_flier_id
  end

  def down
  	rename_column :reservations, :frequent_flier_id, :frequentflier_id
  end
end
