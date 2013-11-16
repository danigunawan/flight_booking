require 'spec_helper'

describe AirportAirline do
	before do
		@airport = Airport.create(city: "San Francisco", country: "United States of America", i_code: "SFO", name: "San Francisco International Airport", phone: 6508218211)
		@airline = Airline.create(name: "Virgin America", phone: 6505552513)
		@airportairline = @airport.airport_airlines.build(airline_id: @airline.id)
	end

	subject {@airportairline}

	it {should respond_to(:airport_id)}
	it {should respond_to(:airport_id)}
	
	it {should be_valid}

	describe "Validations: " do
		describe "should validate that airport_id is present" do

			before {@airportairline.airport_id = nil}
			it {should_not be_valid}
		end

		describe "should validate that airline_id is present" do
			before {@airportairline.airline_id = nil}
			it {should_not be_valid}
		end
	end
end