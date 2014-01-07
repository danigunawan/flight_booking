require 'spec_helper'

describe FlightsController do
	describe "show" do

		let(:airline) {FactoryGirl.create(:airline, :set_name => "Virgin America")}
		let!(:airport1) {FactoryGirl.create(:airport, :set_name => "San Francisco International Airport")}
		let!(:airport2) {FactoryGirl.create(:airport, :set_name => "Los Angeles International Airport")}
		let(:flight) {FactoryGirl.create(:flight, airline: airline, set_origin_airport: airport1.id, set_destination_airport: airport2.id, set_bus_fare: 500, set_eco_fare: 250)}
		let!(:plane) {FactoryGirl.create(:plane, flight: flight)}

		describe "Build Selects:" do

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
	end

	describe "filter" do

		let(:airline) {FactoryGirl.create(:airline)}
		let(:airline2) {FactoryGirl.create(:airline)}
		let(:airline3) {FactoryGirl.create(:airline)}
		let!(:airport) {FactoryGirl.create(:airport)}
		let!(:airport2) {FactoryGirl.create(:airport)}
		let!(:airport3) {FactoryGirl.create(:airport)}
		let(:flight) {FactoryGirl.create(:flight, airline: airline, set_origin_airport: airport.id, set_destination_airport: airport2.id, set_bus_fare: 500, set_eco_fare: 250, set_date: Date.today)}
		let!(:plane) {FactoryGirl.create(:plane, flight: flight)}
		let(:flight1) {FactoryGirl.create(:flight, airline: airline2, set_origin_airport: airport.id, set_destination_airport: airport2.id, set_bus_fare: 500, set_eco_fare: 250, set_date: Date.today)}
		let!(:plane1) {FactoryGirl.create(:plane, flight: flight1)}
		let(:flight2) {FactoryGirl.create(:flight, airline: airline3, set_origin_airport: airport.id, set_destination_airport: airport2.id, set_bus_fare: 500, set_eco_fare: 250, set_date: Date.today)}
		let!(:plane2) {FactoryGirl.create(:plane, flight: flight2)}
		let(:flight3) {FactoryGirl.create(:flight, airline: airline, set_origin_airport: airport2.id, set_destination_airport: airport.id, set_bus_fare: 500, set_eco_fare: 250, set_date: Date.today)}
		let!(:plane3) {FactoryGirl.create(:plane, flight: flight3)}
		let(:flight4) {FactoryGirl.create(:flight, airline: airline2, set_origin_airport: airport2.id, set_destination_airport: airport.id, set_bus_fare: 500, set_eco_fare: 250, set_date: Date.today)}
		let!(:plane4) {FactoryGirl.create(:plane, flight: flight4)}
		let(:flight5) {FactoryGirl.create(:flight, airline: airline3, set_origin_airport: airport2.id, set_destination_airport: airport.id, set_bus_fare: 500, set_eco_fare: 250, set_date: Date.today)}
		let!(:plane5) {FactoryGirl.create(:plane, flight: flight5)}
		let(:flight6) {FactoryGirl.create(:flight, airline: airline, set_origin_airport: airport2.id, set_destination_airport: airport3.id, set_bus_fare: 500, set_eco_fare: 250, set_date: Date.today)}
		let!(:plane6) {FactoryGirl.create(:plane, flight: flight6)}
		let(:flight7) {FactoryGirl.create(:flight, airline: airline2, set_origin_airport: airport2.id, set_destination_airport: airport3.id, set_bus_fare: 500, set_eco_fare: 250, set_date: Date.today)}
		let!(:plane7) {FactoryGirl.create(:plane, flight: flight7)}
		let(:flight8) {FactoryGirl.create(:flight, airline: airline3, set_origin_airport: airport2.id, set_destination_airport: airport3.id, set_bus_fare: 500, set_eco_fare: 250, set_date: Date.today)}
		let!(:plane8) {FactoryGirl.create(:plane, flight: flight8)}
		let(:flight9) {FactoryGirl.create(:flight, airline: airline, set_origin_airport: airport3.id, set_destination_airport: airport2.id, set_bus_fare: 500, set_eco_fare: 250, set_date: Date.today)}
		let!(:plane9) {FactoryGirl.create(:plane, flight: flight9)}
		let(:flight10) {FactoryGirl.create(:flight, airline: airline2, set_origin_airport: airport3.id, set_destination_airport: airport2.id, set_bus_fare: 500, set_eco_fare: 250, set_date: Date.today)}
		let!(:plane10) {FactoryGirl.create(:plane, flight: flight10)}
		let(:flight11) {FactoryGirl.create(:flight, airline: airline3, set_origin_airport: airport3.id, set_destination_airport: airport2.id, set_bus_fare: 500, set_eco_fare: 250, set_date: Date.today)}
		let!(:plane11) {FactoryGirl.create(:plane, flight: flight11)}
		let(:flight12) {FactoryGirl.create(:flight, airline: airline, set_origin_airport: airport3.id, set_destination_airport: airport.id, set_bus_fare: 500, set_eco_fare: 250, set_date: Date.today)}
		let!(:plane12) {FactoryGirl.create(:plane, flight: flight12)}
		let(:flight13) {FactoryGirl.create(:flight, airline: airline2, set_origin_airport: airport3.id, set_destination_airport: airport.id, set_bus_fare: 500, set_eco_fare: 250, set_date: Date.today)}
		let!(:plane13) {FactoryGirl.create(:plane, flight: flight13)}
		let(:flight14) {FactoryGirl.create(:flight, airline: airline3, set_origin_airport: airport3.id, set_destination_airport: airport.id, set_bus_fare: 500, set_eco_fare: 250, set_date: Date.today)}
		let!(:plane14) {FactoryGirl.create(:plane, flight: flight14)}
		let(:flight15) {FactoryGirl.create(:flight, airline: airline, set_origin_airport: airport.id, set_destination_airport: airport3.id, set_bus_fare: 500, set_eco_fare: 250, set_date: Date.today)}
		let!(:plane15) {FactoryGirl.create(:plane, flight: flight15)}
		let(:flight16) {FactoryGirl.create(:flight, airline: airline2, set_origin_airport: airport.id, set_destination_airport: airport3.id, set_bus_fare: 500, set_eco_fare: 250, set_date: Date.today)}
		let!(:plane16) {FactoryGirl.create(:plane, flight: flight16)}
		let(:flight17) {FactoryGirl.create(:flight, airline: airline3, set_origin_airport: airport.id, set_destination_airport: airport3.id, set_bus_fare: 500, set_eco_fare: 250, set_date: Date.today)}
		let!(:plane17) {FactoryGirl.create(:plane, flight: flight17)}

		it "should return flights based on the query string" do
			xhr :get, :filter, :airline_id => 1, :origin_airport_id => "", :dest_airport_id => "", :price => "", :departure_date => "", :min_seat_count => ""

			query_string = "airline_id = :airline_id"
			expect(assigns(:query_string)).to eq(query_string)

		end

		it "should conduct an open query when query string is blank" do
			xhr :get, :filter, :airline_id => "", :origin_airport_id => "", :dest_airport_id => "", :price => "", :departure_date => "", :min_seat_count => ""
			assigns(:flights).should eq([flight, flight1, flight2, flight3, flight4, flight5, flight6, flight7, flight8, flight9, flight10, flight11, flight12, flight13, flight14, flight15, flight16, flight17])
		end

		describe "Parameter Tests:" do

			it "should return all flights for airline 1" do
				xhr :get, :filter, :airline_id => "1", :origin_airport_id => "", :dest_airport_id => "", :price => "", :departure_date => "", :min_seat_count => ""
				assigns(:flights).should eq([flight, flight3, flight6, flight9, flight12, flight15])
			end

			it "should return all flights for airline 1 that start from airport 1" do
				xhr :get, :filter, :airline_id => "1", :origin_airport_id => "1", :dest_airport_id => "", :price => "", :departure_date => "", :min_seat_count => ""
				assigns(:flights).should eq([flight, flight15])
			end

			it "should return all flights for airline 1 that start at airport 1 and end at airport 2" do
				xhr :get, :filter, :airline_id => "1", :origin_airport_id => "1", :dest_airport_id => "2", :price => "", :departure_date => "", :min_seat_count => ""
				assigns(:flights).should eq([flight])
			end

			it "should return all flights for airline 1 that start at airport 1, end at airport 2 and have a fare under 300" do
				xhr :get, :filter, :airline_id => "1", :origin_airport_id => "1", :dest_airport_id => "2", :price => "300", :departure_date => "", :min_seat_count => ""
				assigns(:flights).should eq([flight])
			end

			#Stand alone flight with a date for tomorrow to test date based retrieval.
			let(:flight18) {FactoryGirl.create(:flight, set_date: Date.tomorrow)}
			let!(:plane18) {FactoryGirl.create(:plane, flight: flight18)}
			
			it "should return all flights departing on Date.today" do	
				xhr :get, :filter, :airline_id => "", :origin_airport_id => "", :dest_airport_id => "", :price => "", :departure_date => "#{Date.today}", :min_seat_count => ""
				assigns(:flights).should eq([flight, flight1, flight2, flight3, flight4, flight5, flight6, flight7, flight8, flight9, flight10, flight11, flight12, flight13, flight14, flight15, flight16, flight17])
			end

			#Stand alone flight without any seats to test seat based retrieval.
			let(:flight19) {FactoryGirl.create(:flight, set_date: Date.tomorrow)}
			let!(:plane19) {FactoryGirl.create(:plane, flight: flight19, set_eco_cap: 0, set_bus_cap: 0)}
			it "should not return a flight below the minimum seat threshold" do
				xhr :get, :filter, :airline_id => "", :origin_airport_id => "", :dest_airport_id => "", :price => "", :departure_date => "", :min_seat_count => "1"
				
				assigns(:flights).should eq([flight, flight1, flight2, flight3, flight4, flight5, flight6, flight7, flight8, flight9, flight10, flight11, flight12, flight13, flight14, flight15, flight16, flight17, flight18])
			end
		end

		describe "Query String:" do

			it "should create a query string based on the input params" do
				xhr :get, :filter, :airline_id => 1, :origin_airport_id => 1, :dest_airport_id => 2, :price => 500, :departure_date => '12/31/2013', :min_seat_count => 3
				query_string = "airline_id = :airline_id AND origin_airport = :origin_airport_id AND destination_airport = :dest_airport_id AND (bus_fare <= :price OR eco_fare <= :price) AND date = :departure_date AND bus_avail + eco_avail >= :min_seat_count"
				expect(assigns(:query_string)).to eq(query_string)
			end

			it "should create a blank query string when params are blank" do
				xhr :get, :filter, :airline_id => "", :origin_airport_id => "", :dest_airport_id => "", :price => "", :departure_date => "", :min_seat_count => ""
				expect(assigns(:query_string)).to eq("")
			end
		end

		describe "Input Hash:" do

			it "should create an input hash based on the input params" do
				xhr :get, :filter, :airline_id => 1, :origin_airport_id => 1, :dest_airport_id => 2, :price => 500, :departure_date => '12/31/2013', :min_seat_count => 3
				input_hash = {:airline_id => "1", :origin_airport_id => "1", :dest_airport_id => "2", :price => "500", :departure_date => '12/31/2013', :min_seat_count => 3}
				expect(assigns(:input_hash)).to include(input_hash)
			end

			it "should create an input hash with nil values when params are empty" do
				xhr :get, :filter, :airline_id => "", :origin_airport_id => "", :dest_airport_id => "", :price => "", :departure_date => "", :min_seat_count => ""
				input_hash = {:airline_id => nil, :origin_airport_id => nil, :dest_airport_id => nil, :price => nil, :departure_date => nil, :min_seat_count => nil}
				expect(assigns(:input_hash)).to include(input_hash)
			end
		end

		describe "Build Selects:" do
			it "should create a hash called airlines that contains an array of names and an array of IDs" do
				airlines = {"name" => [airline.name, airline2.name, airline3.name], "id" => [airline.id, airline2.id, airline3.id]}
				xhr :get, :filter, :airline_id => "", :origin_airport_id => "", :dest_airport_id => "", :price => "", :departure_date => "", :min_seat_count => ""

				expect(assigns(:airlines)).to eq(airlines)
			end

			it "should create a hash called destinations that contains an array of airport names and airport ids" do
				destination = {"name" => [airport.name, airport2.name, airport3.name], "id" => [airport.id, airport2.id, airport3.id]}
				xhr :get, :filter, :airline_id => "", :origin_airport_id => "", :dest_airport_id => "", :price => "", :departure_date => "", :min_seat_count => ""

				expect(assigns(:destinations)["name"].sort).to eq(destination["name"].sort)
				expect(assigns(:destinations)["id"].sort).to eq(destination["id"].sort)
			end

			it "should create a hash called origins that contains an array of airport names and airport ids" do
				origin = {"name" => [airport.name, airport2.name, airport3.name], "id" => [airport.id, airport2.id, airport3.id]}
				xhr :get, :filter, :airline_id => "", :origin_airport_id => "", :dest_airport_id => "", :price => "", :departure_date => "", :min_seat_count => ""

				expect(assigns(:origins)["name"].sort).to eq(origin["name"].sort)
				expect(assigns(:origins)["id"].sort).to eq(origin["id"].sort)
			end

			it "should create an array called @display_prices that contains available prices to the next greatest 100" do
				price = [300, 500]
				xhr :get, :filter, :airline_id => "", :origin_airport_id => "", :dest_airport_id => "", :price => "", :departure_date => "", :min_seat_count => ""

				expect(assigns(:display_prices)).to eq(price)
			end
		end

		#describe "This test is literally useless. The Javascript never fires for a controller test" do
		#	it "should receive param[:date] in the 'yyyy,mm,dd' format" do
		#		get :filter, :airline_id => 1, :origin_airport_id => 1, :dest_airport_id => 2, :price => 500, :departure_date => '12/31/2013', :min_seat_count => 3

		#		assigns(:input_hash)["departure_date"].should eq("2013,12,31")
		#	end
		#end
	end
end