class Flight < ActiveRecord::Base
  attr_accessible :airline_id, :arrival, :bus_avail, :bus_fare, :date, :departure, :destination_airport, :eco_avail, :eco_fare, :number, :origin_airport, :plane_id
end
