# == Schema Information
#
# Table name: reservations
#
#  id                :integer          not null, primary key
#  client_id         :integer
#  payment_source    :integer
#  status            :integer
#  preference_id     :integer
#  frequent_flier_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'spec_helper'

describe Reservation do
	before do
		@client = Client.create(address: "435 Test Street", name: "Tester", phone: 6505552832)
		@airline = Airline.create(name: "Virgin America", phone: 6505552513)
		@frequentflier = @airline.build_frequent_flier(discount: 5)
		@frequentflier.save
		@cc = @client.credit_cards.build(cvv2: 123, expiration: Date.today, number: 1234123412341234)
		@cc.save
		@reservation = @client.reservations.build(frequent_flier_id: @frequentflier.id, credit_card_id: @cc.id, preference_id: 5, status: 0)
	end

	subject{@reservation}

	it {should be_valid}

	it {should respond_to(:frequent_flier_id)}
	it {should respond_to(:credit_card)}
	it {should respond_to(:client)}
	it {should respond_to(:preference_id)}
	it {should respond_to(:status)}

	describe "Associations: " do
		it "should belong to a client by the name of Tester" do
			@reservation.client.name.should match "Tester"
		end

		it "should have a credit card with cvv2 123" do
			@reservation.credit_card.cvv2.should be 123
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
	end
end
