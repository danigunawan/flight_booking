class CreateFlightReservations < ActiveRecord::Migration
  def change
    create_table :flight_reservations do |t|
      t.integer :flight_id
      t.integer :reservation_id

      t.timestamps
    end

    add_index :flight_reservations, :flight_id
    add_index :flight_reservations, :reservation_id
    add_index :flight_reservations, [:flight_id, :reservation_id], unique: true
  end
end
