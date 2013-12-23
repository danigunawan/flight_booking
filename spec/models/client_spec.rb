# == Schema Information
#
# Table name: clients
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  address    :string(255)
#  phone      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Client do
	let(:client) {FactoryGirl.create(:client)}

	subject{client}

	it {should be_valid}

	it {should respond_to(:address)}
	it {should respond_to(:name)}
	it {should respond_to(:phone)}
	it {should respond_to(:frequent_flier_memberships)}
	it {should respond_to(:frequent_flier_clients)}
	it {should respond_to(:credit_cards)}
	it {should respond_to(:reservations)}
	it {should respond_to(:preference)}

	describe "Associations: " do
		let(:agent) {FactoryGirl.create(:agent)}
		let(:airline) {FactoryGirl.create(:airline, :set_name => "Virgin America")}
		let(:airport) {FactoryGirl.create(:airport)}
		let(:cc) {FactoryGirl.create(:credit_card, client: client, :set_cvv2 => 123)}
		let(:frequentflier) {FactoryGirl.create(:frequent_flier, airline: airline, set_discount: 5)}
		let!(:preference) {FactoryGirl.create(:preference, client: client)}
		let(:reservation) {FactoryGirl.create(:reservation, client: client, set_frequent_flier_id: frequentflier.id, set_credit_card_id: cc.id, set_agent_id: agent.id)}
		let(:flight) {FactoryGirl.create(:flight, airline: airline, set_origin_airport: airport.id, set_number: 202)}
		let!(:flight_reservation) {FactoryGirl.create(:flight_reservation, reservation: reservation, set_flight_id: flight.id)}
		let!(:frequent_flier_membership) {FactoryGirl.create(:frequent_flier_client, client: client, set_frequent_flier_id: frequentflier.id)}
		let(:plane) {FactoryGirl.create(:plane, flight: flight)}

		it "should have a frequent flier membership with Virgin America" do
			client.frequent_flier_memberships[0].airline.name.should match "Virgin America"
		end

		it "should have a frequent flier clients with frequent flier" do
			client.frequent_flier_clients[0].frequent_flier_id.should be frequentflier.id
		end

		it "should have a credit card with cvv2 123" do
			client.credit_cards[0].cvv2.should be 123
		end

		it "should have a reservation with flight 202" do
			client.reservations[0].flights[0].number.should be 202
		end

		it "should have a preference specifying an aisle seat" do
			client.preference.seat.should match "Aisle"
		end
	end

	describe "Validations: " do
		describe "should validate that address is present" do
			before {client.address = nil}
			it {should_not be_valid}
		end

		describe "should validate that name is present" do
			before{client.name = nil}
			it {should_not be_valid}
		end

		describe "should validate that phone is present" do
			before{client.phone = nil}
			it {should_not be_valid}
		end
	end
end
