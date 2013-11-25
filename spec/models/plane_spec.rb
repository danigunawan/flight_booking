# == Schema Information
#
# Table name: planes
#
#  id           :integer          not null, primary key
#  manufacturer :string(255)
#  prop_type    :string(255)
#  bus_cap      :integer
#  eco_cap      :integer
#  tail_num     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  flight_id    :integer
#  type         :string(255)
#

require 'spec_helper'

describe Plane do
	before do
		@airport = Airport.create(city: "San Francisco", country: "United States of America", i_code: "SFO", name: "San Francisco International Airport", phone: 6508218211)
		@airline = Airline.create(name: "Virgin America", phone: 6505552513)
		@flight = @airline.flights.build(airline_id: @airline.id, arrival: DateTime.now+(5/24.0), bus_fare: 500, eco_fare: 250, date: Date.today, departure: DateTime.now+(1/24.0), destination_airport: 5, number: 202, origin_airport: @airport.id)
		@flight.save
		@plane = @flight.build_plane(bus_cap: 40, eco_cap: 122, manufacturer: "Boeing", make: "737-800", prop_type: "Jet", tail_num: 4285)
	end

	subject{@plane}

	it {should respond_to(:bus_cap)}
	it {should respond_to(:eco_cap)}
	it {should respond_to(:manufacturer)}
	it {should respond_to(:prop_type)}
	it {should respond_to(:tail_num)}
	it {should respond_to(:make)}
	it {should respond_to(:flight)}

	it {should be_valid}

	describe "Associations: " do
		it "should belong to a flight" do
			@plane.flight.number.should be 202
		end
	end

	describe "Validations: " do
		describe "should validate that bus_cap is present" do
			before {@plane.bus_cap = nil}
			it {should_not be_valid}
		end

		describe "should validate that eco_cap is present" do
			before {@plane.eco_cap = nil}
			it {should_not be_valid}
		end

		describe "should validate that manufacturer is present" do
			before {@plane.manufacturer = nil}
			it {should_not be_valid}
		end

		describe "should validate that make is present" do
			before {@plane.make = nil}
			it {should_not be_valid}
		end

		describe "should validate that prop_type is present" do
			before {@plane.prop_type = nil}
			it {should_not be_valid}
		end

		describe "should validate that tail_num is present" do
			before {@plane.tail_num = nil}
			it {should_not be_valid}
		end

		describe "should validate that flight_id is present" do
			before {@plane.flight_id = nil}
			it {should_not be_valid}
		end
	end
end
