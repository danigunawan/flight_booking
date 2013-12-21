# == Schema Information
#
# Table name: airports
#
#  id         :integer          not null, primary key
#  i_code     :string(255)
#  name       :string(255)
#  country    :string(255)
#  city       :string(255)
#  phone      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Airport do
	let(:airport) {FactoryGirl.create(:airport)}

	subject{airport}

	it {should respond_to(:city)}
	it {should respond_to(:country)}
	it {should respond_to(:i_code)}
	it {should respond_to(:name)}
	it {should respond_to(:phone)}
	it {should respond_to(:airlines)}

	it {should be_valid}

	describe "Relationships: " do
		let(:airline) {FactoryGirl.create(:airline, :set_name => "Virgin America")}
		let!(:airportairline) {FactoryGirl.create(:airport_airline, airline: airline, airport: airport)}

		it "should have Virgin America as an airline" do
			airport.airlines[0].name.should eql("Virgin America")
		end
	end

	describe "Validations: " do
		describe "should validate presence of city" do
			before {airport.city = nil}
			it {should_not be_valid}
		end

		describe "should valiate that country is present" do
			before {airport.country = nil}
			it {should_not be_valid}
		end

		describe "should validate that i_code is present" do
			before {airport.i_code = nil}
			it {should_not be_valid}
		end

		describe "should validate that name is present" do
			before {airport.name = nil}
			it {should_not be_valid}
		end

		describe "should validate that phone is present" do
			before {airport.phone = nil}
			it {should_not be_valid}
		end
	end
end
