require 'spec_helper'

describe Airline do
	before do
		@airline = Airline.new(name: "Virgin America", phone: 6505552513)
	end

	subject{@airline}

	it {should respond_to(:name)}
	it {should respond_to(:phone)}

	it {should be_valid}

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