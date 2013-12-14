require 'spec_helper'

describe FlightsController do
	describe "show" do
		before do
			airport1 = Airport.create(city: "San Francisco", country: "United States of America", i_code: "SFO", name: "San Francisco International Airport", phone: 6508218211)
			airport2 = Airport.create(city: "Los Angeles", country: "United States of America", i_code: "LAX", name: "Los Angeles International Airport", phone: 6508218222)
			airline = Airline.create(name: "Virgin America", phone: 5551234567)
			flight = airline.flights.create(airline_id: airline.id, arrival: DateTime.now+(5/24.0), bus_fare: 500, eco_fare: 250, date: Date.today, departure: DateTime.now+(1/24.0), destination_airport: airport2.id, number: 202, origin_airport: airport1.id)
			flight.create_plane(bus_cap: 40, eco_cap: 122, manufacturer: "Boeing", make: "737-800", prop_type: "Jet", tail_num: 4285)
		end

		it "should create a hash called airlines that contains an array of names and an array of IDs" do
			airline = {"name" => ["Virgin America"], "id" => [1]}
			get :show
			expect(assigns(:airlines)).to eq(airline)
		end

		it "should create a hash called destinations that contains an array of airport names and airport ids" do
			destination = {"name" => ["Los Angeles International Airport"], "id" => [2]}
			get :show
			expect(assigns(:destinations)).to eq(destination)
		end

		it "should create a hash called origins that contains an array of airport names and airport ids" do
			origin = {"name" => ["San Francisco International Airport"], "id" => [1]}
			get :show
			expect(assigns(:origins)).to eq(origin)
		end

		it "should create an array called @display_prices that contains available prices to the next greatest 100" do
			price = [300, 500]
			get :show
			expect(assigns(:display_prices)).to eq(price)
		end
	end

	describe "filter" do
		before do
			airport1 = Airport.create(city: "San Francisco", country: "United States of America", i_code: "SFO", name: "San Francisco International Airport", phone: 6508218211)
			airport2 = Airport.create(city: "Los Angeles", country: "United States of America", i_code: "LAX", name: "Los Angeles International Airport", phone: 6508218222)
			airline = Airline.create(name: "Virgin America", phone: 5551234567)
			flight = airline.flights.create(airline_id: airline.id, arrival: DateTime.now+(5/24.0), bus_fare: 500, eco_fare: 250, date: Date.today, departure: DateTime.now+(1/24.0), destination_airport: airport2.id, number: 202, origin_airport: airport1.id)
			flight.create_plane(bus_cap: 40, eco_cap: 122, manufacturer: "Boeing", make: "737-800", prop_type: "Jet", tail_num: 4285)
			airport3 = Airport.create(city: "San Jose", country: "United States of America", i_code: "SJC", name: "San Jose International Airport", phone: 6508218211)
			airport4 = Airport.create(city: "Los Vegas", country: "United States of America", i_code: "LAS", name: "Los Vegas International Airport", phone: 6508218222)
			airline2 = Airline.create(name: "United Airlines", phone: 5551234567)
			flight2 = airline.flights.create(airline_id: airline.id, arrival: DateTime.now+(5/24.0), bus_fare: 550, eco_fare: 300, date: Date.today, departure: DateTime.now+(1/24.0), destination_airport: airport2.id, number: 202, origin_airport: airport1.id)
			flight2.create_plane(bus_cap: 40, eco_cap: 122, manufacturer: "Boeing", make: "737-800", prop_type: "Jet", tail_num: 4285)
		end
	end
end