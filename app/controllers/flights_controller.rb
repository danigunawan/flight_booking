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

	def filter

		@query_string = construct_query(params)
		@input_hash = process_params_hash(params)
		
		if @query_string.blank?
			@flights = Flight.paginate(:page => params[:page]).where("eco_avail > 0 OR bus_avail > 0")
		else
			@flights = Flight.paginate(:page => params[:page]).where(@query_string, @input_hash)
		end

		extract = build_selects(@flights)

		@airlines = extract[:airlines]

		@destinations = extract[:destinations]

		@origins = extract[:origins]

		@display_prices = extract[:display_prices]

		respond_to do |format|
			format.js
		end
	end

	private

	def construct_query(params)

		input_hash = process_params_hash(params)

		#Build the query string
		#query_string
		query_string = ""
		#a counter for and status
		and_counter = 0
		input_hash.each do |key, value|
			#Check for a nil value, if found, do not append to string for this pass
		    if value != nil
		    	#check for stationID
		    	
		        if key.to_s.eql?("airline_id")
		        	#check for an and_value
		        	if and_counter == 1
		        		#add an AND to the query string
		        		query_string = query_string + " AND "
		        	end
		        	#add a query for station ID to the query_string
		        	query_string = query_string + "airline_id = :airline_id"
		        	#set the and_counter to 1 as an AND will be needed if another item is appended
		        	and_counter = 1
		        end
		        #check for charID
		        if key.to_s.eql?("origin_airport_id")
		        	#check for an and_value
		        	if and_counter == 1
		        		#add an AND to the query string
		        		query_string = query_string + " AND "
		        	end
		        	#append a query for char_id to the query_string
		        	query_string = query_string + "origin_airport = :origin_airport_id"
		        	#set the and_counter to 1 as an AND will be needed if another item is appended
		        	and_counter = 1
		        end
		        #check for ownerID
		        if key.to_s.eql?("dest_airport_id")
		        	if and_counter == 1
		        		query_string = query_string + " AND "
		        	end
		        	query_string = query_string + "destination_airport = :dest_airport_id"
		        	and_counter = 1
		        end
		        #check for bid
		        if key.to_s.eql?("price")
		        	if and_counter == 1
		        		query_string = query_string + " AND "
		        	end
		        	query_string = query_string + "bus_fare <= :price OR eco_fare <= :price"
		        	and_counter = 1
		        end
		        #check for departure date
		        if key.to_s.eql?("departure_date")
		        	if and_counter == 1
		        		query_string = query_string + " AND "
		        	end
		        	query_string = query_string + "date = :departure_date"
		        	and_counter = 1
		        end
		        #check for min seats
		        if key.to_s.eql?("min_seat_count")
		        	if and_counter == 1
		        		query_string = query_string + " AND "
		        	end
		        	query_string = query_string + "bus_avail + eco_avail >= :min_seat_count"
		        	and_counter = 1
		        end
		    end
		end

		return query_string

	end

	def process_params_hash(params)
		input_hash = Hash.new

		params.each do |key, value|
			input_hash.merge!(value.eql?("") ? {key.to_sym => nil} : {key.to_sym => value})
		end

		return input_hash
	end

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
