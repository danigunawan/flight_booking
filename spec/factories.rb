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
end