# == Schema Information
#
# Table name: agents
#
#  id             :integer          not null, primary key
#  reservation_id :integer
#  name           :string(255)
#  start_date     :date
#  end_date       :date
#  status         :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'spec_helper'

describe Agent do
	let (:agent) {FactoryGirl.create(:agent)}
	let (:airline) {FactoryGirl.create(:airline)}
	let (:client) {FactoryGirl.create(:client, :set_name => "Tester")}
	let (:cc) {FactoryGirl.create(:credit_card, client: client)}
	let(:frequentflier) {FactoryGirl.create(:frequent_flier, airline: airline, set_discount: 5)}

	subject{agent}

	it {should be_valid}

	it {should respond_to(:name)}
	it {should respond_to(:start_date)}
	it {should respond_to(:status)}
	it {should respond_to(:reservations)}

	describe "Associations: " do
		let!(:reservation) {FactoryGirl.create(:reservation, client: client, set_frequent_flier_id: frequentflier.id, set_credit_card_id: cc.id, set_agent_id: agent.id)}
		
		it "should have a reservation with a client named Tester" do
			agent.reservations[0].client.name.should match "Tester"
		end
	end

	describe "Validations: " do
		describe "should validate that name is present" do
			before {agent.name = nil}
			it {should_not be_valid}
		end

		describe "should validate that start_date is present" do
			before {agent.start_date = nil}
			it {should_not be_valid}
		end

		describe "should validate that status is present" do
			before {agent.status = nil}
			it {should_not be_valid}
		end
	end

end
