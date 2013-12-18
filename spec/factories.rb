FactoryGirl.define do
	
	factory :agent do
		sequence(:name) {|n| "Agent #{n}"}
		start_date Date.today
		status 1

		factory :fired_agent do
			status 0
		end
	end
end