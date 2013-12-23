# == Schema Information
#
# Table name: flights
#
#  id                  :integer          not null, primary key
#  airline_id          :integer
#  number              :integer
#  date                :date
#  departure           :datetime
#  arrival             :datetime
#  origin_airport      :integer
#  destination_airport :integer
#  bus_fare            :integer
#  eco_fare            :integer
#  bus_avail           :integer
#  eco_avail           :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'spec_helper'

describe Flight do
	let(:airline) {FactoryGirl.create(:airline, :set_name => "Virgin America")}
	let!(:flight) {FactoryGirl.create(:flight, airline: airline)}

	subject{flight}

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
	it {should respond_to(:flight_reservations)}
	it {should respond_to(:reservations)}

	it {should be_valid}

	describe "Associations: " do
		let(:agent) {FactoryGirl.create(:agent)}
		let(:client) {FactoryGirl.create(:client, :set_name => "Tester")}
		let(:cc) {FactoryGirl.create(:credit_card, client: client)}
		let(:frequentflier) {FactoryGirl.create(:frequent_flier, airline: airline, set_discount: 5)}
		let(:reservation) {FactoryGirl.create(:reservation, client: client, set_frequent_flier_id: frequentflier.id, set_credit_card_id: cc.id, set_agent_id: agent.id)}
		let!(:flight_reservation) {FactoryGirl.create(:flight_reservation, reservation: reservation, set_flight_id: flight.id)}
		let!(:plane) {FactoryGirl.create(:plane, flight: flight)}

		it "should be a flight for Virgin America" do
			Airline.where("id = ?", flight.airline_id)[0].name.should match "Virgin America"
		end

		it "should have a reservation with client Tester" do
			flight.reservations[0].client.name.should match "Tester"
		end

		it "should have a plane with tail number 4285" do
			flight.plane.tail_num.should be 4285
		end

		describe "Call Backs: " do
			before {@flight = Flight.where("id = ?", flight.id)[0]}

			it "should update bus_avail on flight" do
				flight.bus_avail.should eq plane.bus_cap
			end

			it "should update eco_avail on flight" do
				flight.eco_avail.should eq plane.eco_cap
			end
		end
	end

	describe "Validations: " do
		describe "should validate that airline_id is present" do
			before {flight.airline_id = nil}
			it {should_not be_valid}
		end

		describe "should validate that arrival is present" do
			before {flight.arrival = nil}
			it {should_not be_valid}
		end

		describe "should validate that bus_fare is present" do
			before {flight.bus_fare = nil}
			it {should_not be_valid}
		end

		describe "should validate that eco_fare is present" do
			before {flight.eco_fare = nil}
			it {should_not be_valid}
		end

		describe "should validate that date is present" do
			before {flight.date = nil}
			it {should_not be_valid}
		end

		describe "should validate that departure is present" do
			before {flight.departure = nil}
			it {should_not be_valid}
		end

		describe "should validate that destination_airport is present" do
			before {flight.destination_airport = nil}
			it {should_not be_valid}
		end

		describe "should validate that number is present" do
			before {flight.number = nil}
			it {should_not be_valid}
		end

		describe "should validate that origin_airport is present" do
			before {flight.origin_airport = nil}
			it {should_not be_valid}
		end
	end
end
