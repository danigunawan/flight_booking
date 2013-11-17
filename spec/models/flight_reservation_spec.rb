require 'spec_helper'

describe FlightReservation do
	before do
		@client = Client.create(address: "435 Test Street", name: "Tester", phone: 6505552832)
		@airline = Airline.create(name: "Virgin America", phone: 6505552513)
		@frequentflier = @airline.build_frequent_flier(discount: 5)
		@frequentflier.save
		@cc = @client.credit_cards.build(cvv2: 123, expiration: Date.today, number: 1234123412341234)
		@cc.save
		@agent = Agent.create(name: "John Mcormik", start_date: Date.today, status: 1)
		@reservation = @client.reservations.build(frequent_flier_id: @frequentflier.id, credit_card_id: @cc.id, preference_id: 5, status: 0, agent_id: @agent.id)
		@reservation.save
		@airport = Airport.create(city: "San Francisco", country: "United States of America", i_code: "SFO", name: "San Francisco International Airport", phone: 6508218211)
		@flight = @airline.flights.build(airline_id: @airline.id, arrival: DateTime.now+(5/24.0), bus_fare: 500, eco_fare: 250, date: Date.today, departure: DateTime.now+(1/24.0), destination_airport: 5, number: 202, origin_airport: @airport.id)
		@flight.save
		@plane = @flight.build_plane(bus_cap: 40, eco_cap: 122, manufacturer: "Boeing", type: "737-800", prop_type: "Jet", tail_num: 4285)
		@flight_reservation = @reservation.flight_reservations.build(flight_id: @flight.id)
	end

	subject {@flight_reservation}

	it {should be_valid}

	it {should respond_to(:flight)}
	it {should respond_to(:reservation)}

	describe "Validations: " do
		describe "should validate that flight_id is present" do
			before {@flight_reservation.flight_id = nil}
			it {should_not be_valid}
		end

		describe "should validate that reservation_id is present" do
			before {@flight_reservation.reservation_id = nil}
			it {should_not be_valid}
		end
	end
end