require 'spec_helper'

describe Airline do
	before do
		@airport = Airport.create(city: "San Francisco", country: "United States of America", i_code: "SFO", name: "San Francisco International Airport", phone: 6508218211)
		@airline = Airline.create(name: "Virgin America", phone: 6505552513)
		@airportairline = @airport.airport_airlines.build(airline_id: @airline.id)
		@airportairline.save
		@flight = @airline.flights.build(airline_id: @airline.id, arrival: DateTime.now+(5/24.0), bus_fare: 500, eco_fare: 250, date: Date.today, departure: DateTime.now+(1/24.0), destination_airport: 5, number: 202, origin_airport: @airport.id)
		@flight.save
	end

	subject{@airline}

	it {should respond_to(:name)}
	it {should respond_to(:phone)}
	it {should respond_to(:airports)}
	it {should respond_to(:flights)}

	it {should be_valid}

	describe "Relationships: " do
		it "should have SFO as it's airport" do
			@airline.airports[0].name.should match "San Francisco International Airport"
		end
		it "should have a flight numbered 202" do
			@airline.flights[0].number.should be 202
		end
	end


	describe "Validations: " do
		describe "should validate that name is present" do
			before {@airline.name = nil}
			it {should_not be_valid}
		end

		describe "should validate that phone is present" do
			before {@airline.phone = nil}
			it {should_not be_valid}
		end
	end
end