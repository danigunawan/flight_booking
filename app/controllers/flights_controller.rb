class FlightsController < ApplicationController
	def show
		@flights = Flight.paginate(:page => params[:page]).where("eco_avail > 0 OR bus_avail > 0")

		extract = build_selects(@flights)

		@airlines = extract[:airlines]

		@destinations = extract[:destinations]

		@origins = extract[:origins]

		@display_prices = extract[:display_prices]

		#use a jquery date picker for date selection.
		#http://jqueryui.com/datepicker/
		#@dater = @departure_date[0]
		#date = Date.parse(@date)
		render 'index'
	end

	private

	def calc_display_prices(fares)
		#Takes a fares object and outputs a sorted array of unique fare prices rounded to the next highest hundred.
		#eg, a fare of 250 becomes 300, and a fare of 225 becomes 300.
		display_prices = []
		fares.each do |f|
			next_hundred = (f/100.to_f).ceil*100
			unless display_prices.include?(next_hundred)
				display_prices.push(next_hundred)
			end
		end

		return display_prices.sort
	end

	def build_selects(flights)
		#Takes a flights object, and extracts out all unique destinations, origins and airlines.
		#Invokes calc_display_prices to produce a fare list.

		id = []
		name = []
		orig_id = []
		orig_name = []
		dest_id = []
		dest_name = []
		fares = []
		departure_dt = []
		arrival_dt = []

		flights.each do |f|
			airline = f.airline
			id.include?(airline.id) ? nil : id.push(f.airline.id)
			name.include?(airline.name) ? nil : name.push(airline.name)
			orig_id.include?(f.origin_airport) ? nil : orig_id.push(f.origin_airport)
			dest_id.include?(f.destination_airport) ? nil : dest_id.push(f.destination_airport)
			fares.include?(f.eco_fare) ? nil : fares.push(f.eco_fare)
			fares.include?(f.bus_fare) ? nil : fares.push(f.bus_fare)
		end
		airlines = {"name" => name, "id" => id}

		dest_id.each do |di|
			dest_name.push(Airport.where("id = ?", di)[0].name)
		end
		destinations = {"name" => dest_name, "id" => dest_id}

		orig_id.each do |oi|
			orig_name.push(Airport.where("id = ?", oi)[0].name)
		end
		origins = {"name" => orig_name, "id" => orig_id}

		return {:airlines => airlines, :destinations => destinations, :origins => origins, :display_prices => calc_display_prices(fares)}
	end
end
