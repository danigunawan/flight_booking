class FlightsController < ApplicationController
	def show
		id = []
		name = []
		orig_id = []
		orig_name = []
		dest_id = []
		dest_name = []
		fares = []
		departure_dt = []
		arrival_dt = []
		@flights = Flight.paginate(:page => params[:page]).where("eco_avail > 0 OR bus_avail > 0")

		@flights.each do |f|
		#Flight.limit(30).each do |f|
			airline = f.airline
			id.include?(airline.id) ? nil : id.push(f.airline.id)
			name.include?(airline.name) ? nil : name.push(airline.name)
			orig_id.include?(f.origin_airport) ? nil : orig_id.push(f.origin_airport)
			dest_id.include?(f.destination_airport) ? nil : dest_id.push(f.destination_airport)
			fares.include?(f.eco_fare) ? nil : fares.push(f.eco_fare)
			fares.include?(f.bus_fare) ? nil : fares.push(f.bus_fare)
			departure_dt.include?(f.departure) ? nil : departure_dt.push(f.departure)
			arrival_dt.include?(f.arrival) ? nil : arrival_dt.push(f.arrival)
		end
		@airlines = {"name" => name, "id" => id}

		dest_id.each do |di|
			dest_name.push(Airport.where("id = ?", di)[0].name)
		end
		@destinations = {"name" => dest_name, "id" => dest_id}

		orig_id.each do |oi|
			orig_name.push(Airport.where("id = ?", oi)[0].name)
		end
		@origins = {"name" => orig_name, "id" => orig_id}

		@display_prices = []
		fares.each do |f|
			next_hundred = (f/100.to_f).ceil*100
			unless @display_prices.include?(next_hundred)
				@display_prices.push(next_hundred)
			end
		end

		@departure_date = []
		departure_dt.each do |dt|
			dd = dt.to_date
			unless @departure_date.include?(dd)
				@departure_date.push(dt)
			end
		end

		#use a jquery date picker for date selection.
		#http://jqueryui.com/datepicker/
		#@dater = @departure_date[0]
		#date = Date.parse(@date)


		#@airlines = {"name" => Flight.limit(30).each {|f| f.airline.name}, "id" => Flight.limit(30).each {|f| f.airline.id}}
		#@airlines = {"name" => airlines.pluck("name"), "id" => Airline.pluck("id")}
		render 'index'
	end
end
