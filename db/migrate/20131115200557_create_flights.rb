class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.integer :airline_id
      t.integer :number
      t.date :date
      t.datetime :departure
      t.datetime :arrival
      t.integer :origin_airport
      t.integer :destination_airport
      t.integer :plane_id
      t.integer :bus_fare
      t.integer :eco_fare
      t.integer :bus_avail
      t.integer :eco_avail

      t.timestamps
    end
  end
end
