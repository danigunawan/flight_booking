# == Schema Information
#
# Table name: credit_cards
#
#  id             :integer          not null, primary key
#  client_id      :integer
#  number         :integer
#  cvv2           :integer
#  expiration     :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  reservation_id :integer
#

require 'spec_helper'

describe CreditCard do
	before do
		@client = Client.create(address: "192 Test Street", name: "Tester John", phone: 6502222832)
		@cc = @client.credit_cards.build(cvv2: 123, expiration: Date.today, number: 1234123412341234)
		@cc.save	
	end

	subject{@cc}

	it {should be_valid}

	it {should respond_to(:cvv2)}
	it {should respond_to(:expiration)}
	it {should respond_to(:number)}
	it {should respond_to(:reservations)}

	describe "Associations: " do
		before do
			@airline = Airline.create(name: "Virgin America", phone: 6505552513)
			@frequentflier = @airline.build_frequent_flier(discount: 5)
			@frequentflier.save
			@agent = Agent.create(name: "John Mcormik", start_date: Date.today, status: 1)
			@reservation = @client.reservations.build(frequent_flier_id: @frequentflier.id, credit_card_id: @cc.id, preference_id: 5, status: 0, agent_id: @agent.id)
			@reservation.save
		end

		it "should belong to a client named Tester John" do
			@cc.client.name.should match "Tester John"
		end
		it "should have a reservation with Virgin America" do
			FrequentFlier.where("id = ?", @cc.reservations[0].frequent_flier_id)[0].airline.name.should match "Virgin America"
		end
	end

	describe "Validations: " do
		describe "should validate that cvv2 is present" do
			before {@cc.cvv2 = nil}
			it {should be_invalid}
		end

		describe "should validate that expiration is present" do
			before {@cc.expiration = nil}
			it {should be_invalid}
		end

		describe "should validate that number is present" do
			before {@cc.number = nil}
			it {should be_invalid}
		end

		describe "should validate that client_id is present" do
			before {@cc.client_id = nil}
			it {should be_invalid}
		end
	end
end
