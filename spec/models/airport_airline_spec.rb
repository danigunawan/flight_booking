# == Schema Information
#
# Table name: airport_airlines
#
#  id         :integer          not null, primary key
#  airport_id :integer
#  airline_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe AirportAirline do
	let(:airportairline) {FactoryGirl.create(:airport_airline)}

	subject {airportairline}

	it {should respond_to(:airport_id)}
	it {should respond_to(:airport_id)}
	
	it {should be_valid}

	describe "Validations: " do
		describe "should validate that airport_id is present" do

			before {airportairline.airport_id = nil}
			it {should_not be_valid}
		end

		describe "should validate that airline_id is present" do
			before {airportairline.airline_id = nil}
			it {should_not be_valid}
		end
	end
end
