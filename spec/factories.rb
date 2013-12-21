FactoryGirl.define do
	
	factory :agent do
		sequence(:name) {|n| "Agent #{n}"}
		start_date Date.today
		status 1

		factory :fired_agent do
			status 0
		end
	end

	factory :airline do
		ignore do
			sequence(:set_name) {|n| "Airline #{n}"}
		end

		sequence(:phone) {|n| (5551234567 + n) }
		name {set_name}
	end

	factory :airport do
		ignore do
			sequence(:set_city) {|n| "City #{n}"}
			sequence(:set_country) {|n| "Country #{n}"}
			sequence(:set_i_code) {|n| "Icode #{n}"}
			sequence(:set_name) {|n| "Airport #{n}"}
		end

		sequence(:phone) {|n| (1231233214 + n)}
		city {set_city}
		country {set_country}
		i_code {set_i_code}
		name {set_name}
	end

	factory :airport_airline do
		airport
		airline
	end

	factory :client do
		ignore do
			sequence(:set_address) {|n| "#{n} Test Street"}
			sequence(:set_name) {|n| "Client #{n}"}
			sequence(:set_phone) {|n| (5551234432 + n)}
		end
		address {set_address}
		name {set_name}
		phone {set_phone}
	end

	factory :credit_card do
		ignore do
			sequence(:set_cvv2) {|n| n}
			sequence(:set_number) {|n| (1234123412341234 + n)}
		end

		cvv2 {set_cvv2}
		number {set_number}

		expiration Date.today
		client
	end

	factory :flight do
		ignore do
			set_arrival DateTime.now+(5/24.0)
			sequence(:set_bus_fare) {|n| (500 + n)}
			sequence(:set_eco_fare) {|n| (250 + n)}
			set_date Date.today
			set_departure DateTime.now+(1/24.0)
			sequence(:set_destination_airport) {|n| n}
			sequence(:set_number) {|n| (101 + n)}
			set_origin_airport 0
		end

		arrival {set_arrival}
		bus_fare {set_bus_fare}
		eco_fare {set_eco_fare}
		date {set_date}
		departure {set_departure}
		destination_airport {set_destination_airport}
		number {set_number}
		origin_airport {set_origin_airport}

		airline
	end

	factory :frequent_flier do
		ignore do 
			sequence(:set_discount) {|n| n}
		end

		discount {set_discount}
		airline
	end

	factory :preference do
		ignore do
			set_seat "Aisle"
			set_location "Front"
			set_notes "Test this."
		end

		seat {set_seat}
		location {set_location}
		notes {set_notes}

		client
	end


	factory :reservation do
		ignore do
			set_frequent_flier_id
			set_credit_card_id
			set_preference_id
			set_status 0
			set_agent_id
		end

		client
		agent
		credit_card
		frequent_flier
		preference
	end


end