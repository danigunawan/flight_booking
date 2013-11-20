# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

airports = YAML.load_file("#{Rails.root}/db/seed/airports.yml")
puts "Begining to load airports."
airports.each do |port|
	# sta contains a hash of symbols, not a hash of strings/ints
	yaml_station = Airport.new(name: port[:name], country: port[:country], i_code: port[:i_code], city: port[:city])

	yaml_station[:phone] = rand(1000000000..9999999999)
	yaml_station.save
	puts "Airports are %" + (airports.index(port) / 9).to_s + " finished."
end
puts "Airports Loaded successfully"