class AddStatusColumnToFlightReservation < ActiveRecord::Migration
  def up
  	add_column :flight_reservations, :status, :string
  end
  def down
  	remove_column :flight_reservations, :status
  end
end
