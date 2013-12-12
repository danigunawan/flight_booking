require 'spec_helper'

describe "FlightTable" do
	before do
		airport1 = Airport.create(city: "San Francisco", country: "United States of America", i_code: "SFO", name: "San Francisco International Airport", phone: 6508218211)
		airport2 = Airport.create(city: "Los Angeles", country: "United States of America", i_code: "LAX", name: "Los Angeles International Airport", phone: 6508218222)
		airline = Airline.create(name: "Virgin America", phone: 5551234567)
		flight = airline.flights.create(airline_id: airline.id, arrival: DateTime.now+(5/24.0), bus_fare: 500, eco_fare: 250, date: Date.today, departure: DateTime.now+(1/24.0), destination_airport: airport2.id, number: 202, origin_airport: airport1.id)
		flight.create_plane(bus_cap: 40, eco_cap: 122, manufacturer: "Boeing", make: "737-800", prop_type: "Jet", tail_num: 4285)
	end

	it "should have a tbody with id 'flight_tbody'" do
		render :partial => "flights/flight_table.html.erb"
	end
end