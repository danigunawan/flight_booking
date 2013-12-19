# == Schema Information
#
# Table name: reservations
#
#  id                :integer          not null, primary key
#  client_id         :integer
#  credit_card_id    :integer
#  status            :integer
#  preference_id     :integer
#  frequent_flier_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  agent_id          :integer
#

require 'spec_helper'

describe Reservation do
	let(:agent) {FactoryGirl.create(:agent)}
	let(:airline) {FactoryGirl.create(:airline, :set_name => "Virgin America")}
	before do
		@client = Client.create(address: "435 Test Street", name: "Tester", phone: 6505552832)
		@frequentflier = airline.build_frequent_flier(discount: 5)
		@frequentflier.save
		@cc = @client.credit_cards.build(cvv2: 123, expiration: Date.today, number: 1234123412341234)
		@cc.save
		@reservation = @client.reservations.build(frequent_flier_id: @frequentflier.id, credit_card_id: @cc.id, preference_id: 5, status: 0, agent_id: agent.id)
		@reservation.save
	end

	subject{@reservation}

	it {should be_valid}

	it {should respond_to(:frequent_flier_id)}
	it {should respond_to(:credit_card_id)}
	it {should respond_to(:client)}
	it {should respond_to(:preference_id)}
	it {should respond_to(:status)}
	it {should respond_to(:agent)}
	it {should respond_to(:flight_reservations)}
	it {should respond_to(:flights)}

	describe "Associations: " do
		let(:airport) {FactoryGirl.create(:airport)}
		before do
			@flight = airline.flights.build(airline_id: airline.id, arrival: DateTime.now+(5/24.0), bus_fare: 500, eco_fare: 250, date: Date.today, departure: DateTime.now+(1/24.0), destination_airport: 5, number: 202, origin_airport: airport.id)
			@flight.save
			@plane = @flight.build_plane(bus_cap: 40, eco_cap: 122, manufacturer: "Boeing", make: "737-800", prop_type: "Jet", tail_num: 4285)
			@flight_reservation = @reservation.flight_reservations.build(flight_id: @flight.id)
			@flight_reservation.save
		end
	
		it "should belong to a client by the name of Tester" do
			@reservation.client.name.should match "Tester"
		end

		it "should have a credit card with cvv2 123" do
			CreditCard.where("id = ?", @reservation.credit_card_id)[0].cvv2.should be 123
		end

		it "should have a flight with Virgin America" do
			@reservation.flights[0].airline.name.should match "Virgin America"
		end

		it "should have a flight reservation with flight 202" do
			@reservation.flight_reservations[0].flight.number.should be 202
		end
	end

	describe "Validations: " do
		describe "should validate that client_id is present" do
			before {@reservation.client_id = nil}
			it {should_not be_valid}
		end

		describe "should validate that frequent_flier_id is present" do
			before {@reservation.frequent_flier_id = nil}
			it {should_not be_valid}
		end

		describe "should validate that credit_id is present" do
			before {@reservation.credit_card_id = nil}
			it {should_not be_valid}
		end

		describe "should validate that preference_id is present" do
			before {@reservation.preference_id = nil}
			it {should_not be_valid}
		end

		describe "should validate that status is present" do
			before {@reservation.status = nil}
			it {should_not be_valid}
		end

		describe "should validate that agent_id is present" do
			before {@reservation.agent_id = nil}
			it {should_not be_valid}
		end
	end
end
