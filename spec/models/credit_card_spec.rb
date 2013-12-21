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
	let(:client) {FactoryGirl.create(:client, :set_name => "Tester John")}
	let(:cc) {FactoryGirl.create(:credit_card, client: client)}

	subject{cc}

	it {should be_valid}

	it {should respond_to(:cvv2)}
	it {should respond_to(:expiration)}
	it {should respond_to(:number)}
	it {should respond_to(:reservations)}

	describe "Associations: " do
		let(:agent) {FactoryGirl.create(:agent)}
		let(:airline) {FactoryGirl.create(:airline, :set_name => "Virgin America")}
		before do
			@frequentflier = airline.build_frequent_flier(discount: 5)
			@frequentflier.save
			@reservation = client.reservations.build(frequent_flier_id: @frequentflier.id, credit_card_id: cc.id, preference_id: 5, status: 0, agent_id: agent.id)
			@reservation.save
		end

		it "should belong to a client named Tester John" do
			cc.client.name.should match "Tester John"
		end
		it "should have a reservation with Virgin America" do
			FrequentFlier.where("id = ?", cc.reservations[0].frequent_flier_id)[0].airline.name.should match "Virgin America"
		end
	end

	describe "Validations: " do
		describe "should validate that cvv2 is present" do
			before {cc.cvv2 = nil}
			it {should be_invalid}
		end

		describe "should validate that expiration is present" do
			before {cc.expiration = nil}
			it {should be_invalid}
		end

		describe "should validate that number is present" do
			before {cc.number = nil}
			it {should be_invalid}
		end

		describe "should validate that client_id is present" do
			before {cc.client_id = nil}
			it {should be_invalid}
		end
	end
end
