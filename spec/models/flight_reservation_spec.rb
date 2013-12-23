# == Schema Information
#
# Table name: flight_reservations
#
#  id             :integer          not null, primary key
#  flight_id      :integer
#  reservation_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  status         :string(255)
#

require 'spec_helper'

describe FlightReservation do
	let(:agent) {FactoryGirl.create(:agent)}
	let(:airline) {FactoryGirl.create(:airline)}
	let(:airport) {FactoryGirl.create(:airport)}
	let(:client) {FactoryGirl.create(:client)}
	let(:cc) {FactoryGirl.create(:credit_card, client: client)}
	let!(:flight) {FactoryGirl.create(:flight, set_origin_airport: airport.id, airline: airline)}
	let(:frequentflier) {FactoryGirl.create(:frequent_flier, set_discount: 5)}
	let(:reservation) {FactoryGirl.create(:reservation, client: client, set_frequent_flier_id: frequentflier.id, set_credit_card_id: cc.id, set_agent_id: agent.id)}
	let(:flight_reservation) {FactoryGirl.create(:flight_reservation, reservation: reservation, set_flight_id: flight.id)}

	before do
		@plane = flight.build_plane(bus_cap: 40, eco_cap: 122, manufacturer: "Boeing", make: "737-800", prop_type: "Jet", tail_num: 4285)
	end

	subject {flight_reservation}

	it {should be_valid}

	it {should respond_to(:flight)}
	it {should respond_to(:reservation)}
	it {should respond_to(:status)}

	describe "Validations: " do
		it "should validate that flight_id is present" do
			flight_reservation.flight_id = nil
			flight_reservation.should_not be_valid
		end

		it "should validate that reservation_id is present" do
			flight_reservation.reservation_id = nil
			flight_reservation.should_not be_valid
		end
	end

	describe "Defaults: " do
		it "should have status == 'Waitlisted' if status is not set at build" do
			flight_reservation.status.should match "Waitlisted"
		end

		it "should not have status == 'Waitlisted' when status is updated" do
			flight_reservation.status = "Reserved"
			flight_reservation.status.should match "Reserved"
		end

		it "should not have status == 'Waitlisted' when status is set at build" do
			flight_reservation = reservation.flight_reservations.build(flight_id: flight.id, status: "Reserved")
			flight_reservation.status.should match "Reserved"
		end
	end
end
