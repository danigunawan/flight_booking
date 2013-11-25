namespace :db  do
  desc "Populates the DB with flights, frequent flier programs, agents, clients and "
  task :populate_flights => :environment do
    puts "Populating flights"
    airline = Airline.all

    airline.each do |line|
    	line.airports.each do |port|
    		line.flights.create(arrival: DateTime.now+(5/24.0), bus_fare: 500, eco_fare: 250, date: Date.today, departure: DateTime.now+(1/24.0), destination_airport: (line.airports[rand(0..line.airports.length-1)].id), number: (airline.index(line)+line.airports.index(port)), origin_airport: port.id)
    	end
    	puts "Seeding Flights %" + (airline.index(line) / (airline.length / 100)).to_s + " complete."
    end
  end
end

namespace :db  do
  desc "Populates the DB with frequent flier programs."
  task :populate_ff => :environment do
    puts "Populating frequent flier programs"
    airline = Airline.all

    airline.each do |line|
    	if line.airports.nil? == false
    		line.build_frequent_flier(discount: rand(0..10))
    	end
    	puts "Seeding Frequent Fliers %" + (airline.index(line) / (airline.length / 100)).to_s + " complete."
    end
  end
end

namespace :db  do
  desc "Populates the DB with flights, frequent flier programs, agents, clients and "
  task :populate_agents => :environment do
    puts "Populating agents"
    #50.times{Agent.create(name: )}
    (1..50).each do |a|
    	Agent.create(name: "Agent #{a}", start_date: Date.today, status:1)
    	puts "Populating agents %" + (a*2).to_s + " complete."
    end
  end
end

namespace :db  do
  desc "Populates the DB with flights, frequent flier programs, agents, clients and "
  task :clear => :environment do
  	Flight.destroy_all
    puts "Destroyed all Flights"
    FrequentFlier.destroy_all
    puts "Destroyed all Frequent Flier Programs"
    Agent.destroy_all
    puts "Destroyed all Agents"
  end
end