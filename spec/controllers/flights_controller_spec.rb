require 'spec_helper'

describe FlightsController do
	describe "show" do

		let(:airline) {FactoryGirl.create(:airline, :set_name => "Virgin America")}
		let!(:airport1) {FactoryGirl.create(:airport, :set_name => "San Francisco International Airport")}
		let!(:airport2) {FactoryGirl.create(:airport, :set_name => "Los Angeles International Airport")}
		let(:flight) {FactoryGirl.create(:flight, airline: airline, set_origin_airport: airport1.id, set_destination_airport: airport2.id, set_bus_fare: 500, set_eco_fare: 250)}
		let!(:plane) {FactoryGirl.create(:plane, flight: flight)}

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

		let(:airline) {FactoryGirl.create(:airline)}
		let(:airline2) {FactoryGirl.create(:airline)}
		let(:airline3) {FactoryGirl.create(:airline)}
		let!(:airport) {FactoryGirl.create(:airport)}
		let!(:airport2) {FactoryGirl.create(:airport)}
		let!(:airport3) {FactoryGirl.create(:airport)}
		let(:flight) {FactoryGirl.create(:flight, airline: airline, set_origin_airport: airport.id, set_destination_airport: airport2.id, set_bus_fare: 500, set_eco_fare: 250)}
		let(:flight1) {FactoryGirl.create(:flight, airline: airline2, set_origin_airport: airport.id, set_destination_airport: airport2.id, set_bus_fare: 500, set_eco_fare: 250)}
		let(:flight2) {FactoryGirl.create(:flight, airline: airline3, set_origin_airport: airport.id, set_destination_airport: airport2.id, set_bus_fare: 500, set_eco_fare: 250)}
		let(:flight3) {FactoryGirl.create(:flight, airline: airline, set_origin_airport: airport2.id, set_destination_airport: airport.id, set_bus_fare: 500, set_eco_fare: 250)}
		let(:flight4) {FactoryGirl.create(:flight, airline: airline2, set_origin_airport: airport2.id, set_destination_airport: airport.id, set_bus_fare: 500, set_eco_fare: 250)}
		let(:flight5) {FactoryGirl.create(:flight, airline: airline3, set_origin_airport: airport2.id, set_destination_airport: airport.id, set_bus_fare: 500, set_eco_fare: 250)}
		let(:flight6) {FactoryGirl.create(:flight, airline: airline, set_origin_airport: airport2.id, set_destination_airport: airport3.id, set_bus_fare: 500, set_eco_fare: 250)}
		let(:flight7) {FactoryGirl.create(:flight, airline: airline2, set_origin_airport: airport2.id, set_destination_airport: airport3.id, set_bus_fare: 500, set_eco_fare: 250)}
		let(:flight8) {FactoryGirl.create(:flight, airline: airline3, set_origin_airport: airport2.id, set_destination_airport: airport3.id, set_bus_fare: 500, set_eco_fare: 250)}
		let(:flight9) {FactoryGirl.create(:flight, airline: airline, set_origin_airport: airport3.id, set_destination_airport: airport2.id, set_bus_fare: 500, set_eco_fare: 250)}
		let(:flight10) {FactoryGirl.create(:flight, airline: airline2, set_origin_airport: airport3.id, set_destination_airport: airport2.id, set_bus_fare: 500, set_eco_fare: 250)}
		let(:flight11) {FactoryGirl.create(:flight, airline: airline3, set_origin_airport: airport3.id, set_destination_airport: airport2.id, set_bus_fare: 500, set_eco_fare: 250)}
		let(:flight12) {FactoryGirl.create(:flight, airline: airline, set_origin_airport: airport3.id, set_destination_airport: airport.id, set_bus_fare: 500, set_eco_fare: 250)}
		let(:flight13) {FactoryGirl.create(:flight, airline: airline2, set_origin_airport: airport3.id, set_destination_airport: airport.id, set_bus_fare: 500, set_eco_fare: 250)}
		let(:flight14) {FactoryGirl.create(:flight, airline: airline3, set_origin_airport: airport3.id, set_destination_airport: airport.id, set_bus_fare: 500, set_eco_fare: 250)}
		let(:flight15) {FactoryGirl.create(:flight, airline: airline, set_origin_airport: airport.id, set_destination_airport: airport3.id, set_bus_fare: 500, set_eco_fare: 250)}
		let(:flight16) {FactoryGirl.create(:flight, airline: airline2, set_origin_airport: airport.id, set_destination_airport: airport3.id, set_bus_fare: 500, set_eco_fare: 250)}
		let(:flight17) {FactoryGirl.create(:flight, airline: airline3, set_origin_airport: airport.id, set_destination_airport: airport3.id, set_bus_fare: 500, set_eco_fare: 250)}

		it "should create a query string based on the input params" do
			get :filter, :airline_id => 1, :origin_airport_id => 1, :dest_airport_id => 2, :price => 500, :departure_date => '12/31/2013', :min_seat_count => 3
			query_string = "airline_id = :airline_id AND origin_airport = :origin_airport_id AND destination_airport = :dest_airport_id AND bus_fare <= :price OR eco_fare <= :price AND date = :departure_date AND bus_avail + eco_avail >= :min_seat_count"
			expect(assigns(:query_string)).to eq(query_string)
		end

		it "should create an input hash based on the input params" do
			get :filter, :airline_id => 1, :origin_airport_id => 1, :dest_airport_id => 2, :price => 500, :departure_date => '12/31/2013', :min_seat_count => 3
			input_hash = {:airline_id => "1", :origin_airport_id => "1", :dest_airport_id => "2", :price => "500", :departure_date => '12/31/2013', :min_seat_count => "3"}
			expect(assigns(:input_hash)).to include(input_hash)
		end

		#it "should conduct an open query when query string is blank" do
		#	get :filter

		#	assigns(:flights).should eq([flight, flight1, flight2, flight3, flight4, flight5, flight6, flight7, flight8, flight9, flight10, flight11, flight12, flight13, flight14, flight15,flight16,flight17])
		#end

		#describe "This test is literally useless. The Javascript never fires for a controller test" do
		#	it "should receive param[:date] in the 'yyyy,mm,dd' format" do
		#		get :filter, :airline_id => 1, :origin_airport_id => 1, :dest_airport_id => 2, :price => 500, :departure_date => '12/31/2013', :min_seat_count => 3

		#		assigns(:input_hash)["departure_date"].should eq("2013,12,31")
		#	end
		#end
	end
end