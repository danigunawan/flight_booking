# == Schema Information
#
# Table name: frequent_fliers
#
#  id         :integer          not null, primary key
#  airline_id :integer
#  discount   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe FrequentFlier do
	let(:airline) {FactoryGirl.create(:airline, :set_name => "Virgin America")}
	before do
		@client = Client.create(address: "435 Test Street", name: "Tester", phone: 6505552832)
		@frequentflier = airline.build_frequent_flier(discount: 5)
		@frequentflier.save
	end

	subject{@frequentflier}

	it {should respond_to(:airline)}
	it {should respond_to(:discount)}
	it {should respond_to(:clients)}

	it {should be_valid}

	describe "Associations: " do
		before do
			@frequent_flier_membership = @client.frequent_flier_clients.build(frequent_flier_id: @frequentflier.id)
			@frequent_flier_membership.save
		end
		
		it "should have an airline with the name Virgin America" do
			@frequentflier.airline.name.should match "Virgin America"
		end

		it "should have a client with the name Tester" do
			@frequentflier.clients[0].name.should match "Tester"
		end
	end

	describe "Validations: " do
		describe "it should validate that airline_id is present" do
			before {@frequentflier.airline_id = nil}
			it {should_not be_valid}
		end

		describe "it should validate that discount is present" do
			before {@frequentflier.discount = nil}
			it {should_not be_valid}
		end
	end
end
