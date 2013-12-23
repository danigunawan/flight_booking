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
	let(:airline) {FactoryGirl.create(:airline)}
	let(:airport) {FactoryGirl.create(:airport)}
	let(:flight) {FactoryGirl.create(:flight, airline: airline, set_origin_airport: airport.id, set_number: 202)}
	let(:plane) {FactoryGirl.create(:plane, flight: flight)}

	subject{plane}

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
			plane.flight.number.should be 202
		end
		describe "Call Backs: " do
			it "should update bus_avail on flight" do
				plane.flight.bus_avail.should eq plane.bus_cap
			end

			it "should update eco_avail on flight" do
				plane.flight.eco_avail.should eq plane.eco_cap
			end
		end
	end

	describe "Validations: " do
		describe "should validate that bus_cap is present" do
			before {plane.bus_cap = nil}
			it {should_not be_valid}
		end

		describe "should validate that eco_cap is present" do
			before {plane.eco_cap = nil}
			it {should_not be_valid}
		end

		describe "should validate that manufacturer is present" do
			before {plane.manufacturer = nil}
			it {should_not be_valid}
		end

		describe "should validate that make is present" do
			before {plane.make = nil}
			it {should_not be_valid}
		end

		describe "should validate that prop_type is present" do
			before {plane.prop_type = nil}
			it {should_not be_valid}
		end

		describe "should validate that tail_num is present" do
			before {plane.tail_num = nil}
			it {should_not be_valid}
		end

		describe "should validate that flight_id is present" do
			before {plane.flight_id = nil}
			it {should_not be_valid}
		end
	end
end
