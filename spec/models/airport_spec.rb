require 'spec_helper'

describe Airport do
	before do
		@airport = Airport.new(city: "San Francisco", country: "United States of America", i_code: "SFO", name: "San Francisco International Airport", phone: 6508218211)
	end

	subject{@airport}

	it {should respond_to(:city)}
	it {should respond_to(:country)}
	it {should respond_to(:i_code)}
	it {should respond_to(:name)}
	it {should respond_to(:phone)}

	it {should be_valid}

	describe "Validations:" do
		describe "should validate presence of city" do
			before {@airport.city = nil}
			it {should_not be_valid}
		end

		describe "should valiate that country is present" do
			before {@airport.country = nil}
			it {should_not be_valid}
		end

		describe "should validate that i_code is present" do
			before {@airport.i_code = nil}
			it {should_not be_valid}
		end

		describe "should validate that name is present" do
			before {@airport.name = nil}
			it {should_not be_valid}
		end

		describe "should validate that phone is present" do
			before {@airport.phone = nil}
			it {should_not be_valid}
		end
	end
end