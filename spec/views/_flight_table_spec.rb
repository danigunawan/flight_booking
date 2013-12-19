require 'spec_helper'

describe "FlightTable" do
	let(:airline) {FactoryGirl.create(:airline, :set_name => "Virgin America")}
	let(:airport1) {FactoryGirl.create(:airport)}
	let(:airport2) {FactoryGirl.create(:airport)}
	before do
		flight = airline.flights.create(airline_id: airline.id, arrival: DateTime.now+(5/24.0), bus_fare: 500, eco_fare: 250, date: Date.today, departure: DateTime.now+(1/24.0), destination_airport: airport2.id, number: 202, origin_airport: airport1.id)
		flight.create_plane(bus_cap: 40, eco_cap: 122, manufacturer: "Boeing", make: "737-800", prop_type: "Jet", tail_num: 4285)
		flight2 = airline.flights.create(airline_id: airline.id, arrival: DateTime.now+(5/24.0), bus_fare: 500, eco_fare: 250, date: Date.today, departure: DateTime.now+(1/24.0), destination_airport: airport2.id, number: 202, origin_airport: airport1.id)
		flight2.create_plane(bus_cap: 40, eco_cap: 122, manufacturer: "Boeing", make: "737-800", prop_type: "Jet", tail_num: 4285)
		@flights = [flight]
		@origins = {"name" => [airport1.name], "id" => [airport1.id]}
		@destinations = {"name" => [airport2.name], "id" => [airport2.id]}
	end

	it "should have a tbody with id 'flight_tbody'" do
		render :partial => "flights/flight_table", :locals => {flights: @flights, origins: @origins, destinations: @destinations}
		rendered.should have_selector('tbody#flight_table_tbody')
	end
end