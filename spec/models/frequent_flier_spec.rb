require 'spec_helper'

describe FrequentFlier do
	before do
		@airline = Airline.create(name: "Virgin America", phone: 6505552513)
		@frequentflier = @airline.build_frequent_flier(discount: 5)
	end

	subject{@frequentflier}

	it {should respond_to(:airline)}
	it {should respond_to(:discount)}

	it {should be_valid}

	describe "Associations: " do
		it "should have an airline with the name Virgin America" do
			@frequentflier.airline.name.should match "Virgin America"
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