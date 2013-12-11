require 'spec_helper'

describe "FlightPage" do
	subject {page}

	before do
		airport1 = Airport.create(city: "San Francisco", country: "United States of America", i_code: "SFO", name: "San Francisco International Airport", phone: 6508218211)
		airport2 = Airport.create(city: "Los Angeles", country: "United States of America", i_code: "LAX", name: "Los Angeles International Airport", phone: 6508218222)
		airline = Airline.create(name: "Virgin America", phone: 5551234567)
		flight = airline.flights.create(airline_id: airline.id, arrival: DateTime.now+(5/24.0), bus_fare: 500, eco_fare: 250, date: Date.today, departure: DateTime.now+(1/24.0), destination_airport: airport2.id, number: 202, origin_airport: airport1.id)
		flight.create_plane(bus_cap: 40, eco_cap: 122, manufacturer: "Boeing", make: "737-800", prop_type: "Jet", tail_num: 4285)
			visit root_path
			
	end

	
	describe "drop down box" do
		it "should have a div of class dropdowns" do
			should have_selector('div.dropdowns')
		end

		it "should contain a select with id 'airline_select'" do
			should have_selector('select#airline_select')
		end

		it "should contain a select with id 'origin_select'" do
			should have_selector('select#origin_select')
		end

		it "should contain a select with id 'dest_select'" do
			should have_selector('select#dest_select')
		end

		it "should contain a select with id 'price_select'" do
			should have_selector('select#price_select')
		end

		it "should contain an input with id 'select_date'" do
			should have_selector('input#select_date')
		end
	end
	

end