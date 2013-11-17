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
	before do
		@client = Client.create(address: "435 Test Street", name: "Tester", phone: 6505552832)	
	end

	subject{@client}

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
		before do
			@preference = @client.build_preference(seat: "Aisle", location: "Front", notes: "Test this.")
			@airline = Airline.create(name: "Virgin America", phone: 6505552513)
			@frequentflier = @airline.build_frequent_flier(discount: 5)
			@frequentflier.save
			@frequent_flier_membership = @client.frequent_flier_clients.build(frequent_flier_id: @frequentflier.id)
			@frequent_flier_membership.save
			@cc = @client.credit_cards.build(cvv2: 123, expiration: Date.today, number: 1234123412341234)
			@cc.save
			@airport = Airport.create(city: "San Francisco", country: "United States of America", i_code: "SFO", name: "San Francisco International Airport", phone: 6508218211)
			@agent = Agent.create(name: "John Mcormik", start_date: Date.today, status: 1)
			@reservation = @client.reservations.build(frequent_flier_id: @frequentflier.id, credit_card_id: @cc.id, preference_id: 5, status: 0, agent_id: @agent.id)
			@reservation.save
			@flight = @airline.flights.build(airline_id: @airline.id, arrival: DateTime.now+(5/24.0), bus_fare: 500, eco_fare: 250, date: Date.today, departure: DateTime.now+(1/24.0), destination_airport: 5, number: 202, origin_airport: @airport.id)
			@flight.save
			@plane = @flight.build_plane(bus_cap: 40, eco_cap: 122, manufacturer: "Boeing", type: "737-800", prop_type: "Jet", tail_num: 4285)
			@flight_reservation = @reservation.flight_reservations.build(flight_id: @flight.id)
			@flight_reservation.save
		end

		it "should have a frequent flier membership with Virgin America" do
			@client.frequent_flier_memberships[0].airline.name.should match "Virgin America"
		end

		it "should have a frequent flier clients with frequent flier" do
			@client.frequent_flier_clients[0].frequent_flier_id.should be @frequentflier.id
		end

		it "should have a credit card with cvv2 123" do
			@client.credit_cards[0].cvv2.should be 123
		end

		it "should have a reservation with flight 202" do
			@client.reservations[0].flights[0].number.should be 202
		end

		it "should have a preference specifying an aisle seat" do
			@client.preference.seat.should match "Aisle"
		end
	end

	describe "Validations: " do
		describe "should validate that address is present" do
			before {@client.address = nil}
			it {should_not be_valid}
		end

		describe "should validate that name is present" do
			before{@client.name = nil}
			it {should_not be_valid}
		end

		describe "should validate that phone is present" do
			before{@client.phone = nil}
			it {should_not be_valid}
		end
	end
end
