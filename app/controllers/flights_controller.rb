class FlightsController < ApplicationController
	def show
		id = []
		name = []
		orig_id = []
		orig_name = []
		dest_id = []
		dest_name = []
		Flight.paginate(:page => params[:page]).where("eco_avail > 0 OR bus_avail > 0").each do |f|
		#Flight.limit(30).each do |f|
			airline = f.airline

			id.include?(airline.id) ? nil : id.push(f.airline.id)
			name.include?(airline.name) ? nil : name.push(airline.name)
			orig_id.include?(f.origin_airport) ? nil : orig_id.push(f.origin_airport)
			dest_id.include?(f.destination_airport) ? nil : dest_id.push(f.destination_airport)
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


		#@airlines = {"name" => Flight.limit(30).each {|f| f.airline.name}, "id" => Flight.limit(30).each {|f| f.airline.id}}
		#@airlines = {"name" => airlines.pluck("name"), "id" => Airline.pluck("id")}
		render 'index'
	end
end
