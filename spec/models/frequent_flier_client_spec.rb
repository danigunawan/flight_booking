require 'spec_helper'

describe FrequentFlierClient do
	before do
		@airline = Airline.create(name: "Virgin America", phone: 6505552513)
		#@frequentflier = @airline.frequent_flier.build
	end
end