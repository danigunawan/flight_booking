# == Schema Information
#
# Table name: frequent_flier_clients
#
#  id                :integer          not null, primary key
#  frequent_flier_id :integer
#  client_id         :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'spec_helper'

describe FrequentFlierClient do
	let(:airline) {FactoryGirl.create(:airline)}
	let(:client) {FactoryGirl.create(:client)}
	let(:frequentflier) {FactoryGirl.create(:frequent_flier, airline: airline, set_discount: 5)}
	before do
		@frequentflierclient = client.frequent_flier_clients.build(frequent_flier_id: frequentflier.id)
	end

	subject{@frequentflierclient}

	it {should respond_to(:client_id)}
	it {should respond_to(:frequent_flier_id)}

	it {should be_valid}

	describe "Validations: " do
		describe "should validate client_id is present" do
			before {@frequentflierclient.client_id = nil}
			it {should_not be_valid}
		end

		describe "should validate frequent_flier_id is present" do
			before {@frequentflierclient.frequent_flier_id = nil}
			it {should_not be_valid}
		end
	end
end
