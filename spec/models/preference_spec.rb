# == Schema Information
#
# Table name: preferences
#
#  id         :integer          not null, primary key
#  client_id  :integer
#  location   :string(255)
#  seat       :string(255)
#  notes      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Preference do
	before do
		@client = Client.create(address: "435 Test Street", name: "Tester", phone: 6505552832)
		@preference = @client.build_preference(seat: "Aisle", location: "Front", notes: "Test this.")
	end

	subject{@preference}

	it {should be_valid}

	it {should respond_to(:seat)}
	it {should respond_to(:location)}
	it {should respond_to(:notes)}
	it {should respond_to(:client)}

	describe "Associations: " do
		it "should belong to a client named Tester" do
			@preference.client.name.should match "Tester"
		end
	end
end
