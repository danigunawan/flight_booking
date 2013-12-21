# == Schema Information
#
# Table name: airlines
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  phone      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Airline do
	let(:airline) {FactoryGirl.create(:airline)}
	let(:airport) {FactoryGirl.create(:airport, :set_name => "San Francisco International Airport")}

	subject{airline}

	it {should respond_to(:name)}
	it {should respond_to(:phone)}
	it {should respond_to(:airports)}
	it {should respond_to(:flights)}
	it {should respond_to(:frequent_flier)}

	it {should be_valid}

	describe "Relationships: " do
		let!(:airportairline) {FactoryGirl.create(:airport_airline, airport: airport, airline: airline)}
		let!(:flight) {FactoryGirl.create(:flight, airline: airline, set_origin_airport: airport.id, set_number: 202)}
		let!(:frequentflier) {FactoryGirl.create(:frequent_flier, airline: airline, set_discount: 5)}

		it "should have SFO as it's airport" do
			airline.airports[0].name.should match "San Francisco International Airport"
		end
		it "should have a flight numbered 202" do
			airline.flights[0].number.should be 202
		end
		it "should have a frequent flier program with a discount of 5" do
			airline.frequent_flier.discount.should be 5
		end
	end


	describe "Validations: " do
		describe "should validate that name is present" do
			before {airline.name = nil}
			it {should_not be_valid}
		end

		describe "should validate that phone is present" do
			before {airline.phone = nil}
			it {should_not be_valid}
		end
	end
end
