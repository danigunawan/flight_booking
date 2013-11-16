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
		@airline = Airline.create(name: "Virgin America", phone: 6505552513)
		@frequentflier = @airline.build_frequent_flier(discount: 5)
		@frequentflier.save
		@frequent_flier_membership = @client.frequent_flier_clients.build(frequent_flier_id: @frequentflier.id)
		@frequent_flier_membership.save
		@cc = @client.credit_cards.build(cvv2: 123, expiration: Date.today, number: 1234123412341234)
		@cc.save
	end

	subject{@client}

	it {should be_valid}

	it {should respond_to(:address)}
	it {should respond_to(:name)}
	it {should respond_to(:phone)}
	it {should respond_to(:frequent_flier_memberships)}
	it {should respond_to(:frequent_flier_clients)}
	it {should respond_to(:credit_cards)}

	describe "Associations: " do
		it "should have a frequent flier membership with Virgin America" do
			@client.frequent_flier_memberships[0].airline.name.should match "Virgin America"
		end

		it "should have a credit card with cvv2 123" do
			@client.credit_cards[0].cvv2.should be 123
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
