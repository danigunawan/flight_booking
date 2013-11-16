require 'spec_helper'

describe Flight do
	before do
		@airport = Airport.create(city: "San Francisco", country: "United States of America", i_code: "SFO", name: "San Francisco International Airport", phone: 6508218211)
		@airline = Airline.create(name: "Virgin America", phone: 6505552513)
		@flight = @airline.flights.build(airline_id: @airline.id, arrival: DateTime.now+(5/24.0), bus_fare: 500, eco_fare: 250, date: Date.today, departure: DateTime.now+(1/24.0), destination_airport: 5, number: 202, origin_airport: @airport.id)
		@flight.save
		@plane = @flight.build_plane(bus_cap: 40, eco_cap: 122, manufacturer: "Boeing", type: "737-800", prop_type: "Jet", tail_num: 4285)
	end

	subject{@flight}

	it {should respond_to(:airline_id)}
	it {should respond_to(:arrival)}
	it {should respond_to(:bus_avail)}
	it {should respond_to(:bus_fare)}
	it {should respond_to(:date)}
	it {should respond_to(:departure)}
	it {should respond_to(:destination_airport)}
	it {should respond_to(:eco_avail)}
	it {should respond_to(:eco_fare)}
	it {should respond_to(:number)}
	it {should respond_to(:origin_airport)}
	it {should respond_to(:airline)}

	it {should be_valid}

	describe "Relationships: " do
		it "should be a flight for Virgin America" do
			Airline.where("id = ?", @flight.airline_id)[0].name.should match "Virgin America"
		end
	end

	describe "Validations: " do
		describe "should validate that airline_id is present" do
			before {@flight.airline_id = nil}
			it {should_not be_valid}
		end

		describe "should validate that arrival is present" do
			before {@flight.arrival = nil}
			it {should_not be_valid}
		end

		describe "should validate that bus_fare is present" do
			before {@flight.bus_fare = nil}
			it {should_not be_valid}
		end

		describe "should validate that eco_fare is present" do
			before {@flight.eco_fare = nil}
			it {should_not be_valid}
		end

		describe "should validate that date is present" do
			before {@flight.date = nil}
			it {should_not be_valid}
		end

		describe "should validate that departure is present" do
			before {@flight.departure = nil}
			it {should_not be_valid}
		end

		describe "should validate that destination_airport is present" do
			before {@flight.destination_airport = nil}
			it {should_not be_valid}
		end

		describe "should validate that number is present" do
			before {@flight.number = nil}
			it {should_not be_valid}
		end

		describe "should validate that origin_airport is present" do
			before {@flight.origin_airport = nil}
			it {should_not be_valid}
		end
	end
end