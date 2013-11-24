# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

airports = YAML.load_file("#{Rails.root}/db/seed/airports.yml")
puts "Beginning to load airports."
airports.each do |port|
	# sta contains a hash of symbols, not a hash of strings/ints
	yaml_station = Airport.new(name: port[:name], country: port[:country], i_code: port[:i_code], city: port[:city])

	yaml_station[:phone] = rand(1000000000..9999999999)
	yaml_station.save
	puts "Airports are %" + (airports.index(port) / 9).to_s + " finished."
end
puts "Airports Loaded successfully"

airlines = YAML.load_file("#{Rails.root}/db/seed/airlines.yml")
puts "Beginning to load airlines."
airline_log = []
airlines.each do |line|
	#Check for duplicate airlines
	if airline_log.include?(line[:name]) == false
		#if it is not a dupe, add it to the log
		airline_log.push(line[:name])

		yaml_airline = Airline.create(name: line[:name], phone: rand(1000000000..9999999999))
		#Filter out empty destinations
		if line[:destinations].empty? == false
			dest_log = []
			line[:destinations].each do |dest|
				#Filter out fixnums
				if dest.class == String
					#Filter out alternate i_code or translations
					if dest.length > 3
						dest = dest.slice(0,3)
					end
					#Check for duplicate destination data
					if dest_log.include?(dest) == false
						#if it's not a dupe, add it to the log
						dest_log.push(dest)
						#create airport_airlines
						port = Airport.where("i_code = ?", dest)[0]
						if port.nil? == false
							yaml_airline.airport_airlines.create(airport_id: port.id)
						end
					end
				end
			end
		end
		puts line[:name] + " : Airlines are %" + (airlines.index(line) / 24).to_s + " finished."
	end
end
