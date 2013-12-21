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
end