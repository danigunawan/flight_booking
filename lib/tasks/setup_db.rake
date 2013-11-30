namespace :db do
	desc "Runs all populate tasks"
	task :populate => :environment do
		puts "Running all populate tasks"
		Rake::Task['db:populate_flights'].invoke
		Rake::Task['db:populate_planes'].invoke
		Rake::Task['db:populate_ff'].invoke
		Rake::Task['db:populate_agents'].invoke
		Rake::Task['db:populate_clients'].invoke
		Rake::Task['db:populate_credit_cards'].invoke
		Rake::Task['db:populate_preferences'].invoke
		Rake::Task['db:populate_frequent_flier_clients'].invoke
		Rake::Task['db:populate_reservations'].invoke
		Rake::Task['db:populate_flight_reservations'].invoke
		puts "Populate finished."
	end
end

namespace :db  do
  desc "Populates the DB with flights."
  task :populate_flights => :environment do
    puts "Populating flights"
    airline = Airline.all

    airline.each do |line|
    	line.airports.each do |port|
    		line.flights.create(arrival: DateTime.now+(5/24.0), 
          bus_fare: (line.airports.index(port).even? ? 500 : 800), 
          eco_fare: (line.airports.index(port).even? ? 250 : 350), 
          date: Date.today, 
          departure: DateTime.now+(1/24.0), 
          destination_airport: (line.airports[rand(0..line.airports.length-1)].id), 
          number: (airline.index(line)+line.airports.index(port)), 
          origin_airport: port.id)
    	end
    	puts "Seeding Flights %" + (airline.index(line) / (airline.length / 100)).to_s + " complete."
    end
  end
end

namespace :db do
	desc "Populates the DB with planes for each flight in it."
	task :populate_planes => :environment do
		puts "Populating planes"
		flight = Flight.all
		flight.each do |pl|
			pl.create_plane(bus_cap: 40, eco_cap: 122, manufacturer: "Boeing", make: "737-800", prop_type: "Jet", tail_num: (4220 + flight.index(pl)))

			puts "Populating planes %" + (flight.index(pl) / (flight.length / 100)).to_s + " complete."
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
    		line.create_frequent_flier(discount: rand(0..10))
    	end
    	puts "Seeding Frequent Fliers %" + (airline.index(line) / (airline.length / 100)).to_s + " complete."
    end
  end
end

namespace :db  do
  desc "Populates the DB with agents."
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
  desc "Populates the DB with clients."
  task :populate_clients => :environment do
    puts "Populating clients"
    #50.times{Agent.create(name: )}
    (1..50).each do |c|
    	Client.create(name: "Client #{c}", phone: 7845551234 + c, address: "#{c} Client #{c}'s Street")
    	puts "Populating clients %" + (c*2).to_s + " complete."
    end
  end
end

namespace :db  do
  desc "Populates the DB with credit cards."
  task :populate_credit_cards => :environment do
    puts "Populating credit cards"
    #50.times{Agent.create(name: )}
    client = Client.all
    (1..50).each do |cc|
    	client[cc-1].credit_cards.create(cvv2: 100+cc, expiration: Date.today + (712), number: 1234123412341234+cc)
    	puts "Populating clients %" + (cc*2).to_s + " complete."
    end
  end
end

namespace :db do
	desc "Populates DB with client preferences."
	task :populate_preferences => :environment do
		puts "Populating preferences"
		client = Client.all
		(1..50).each do |p|
			client[p-1].create_preference(seat: p.even? ? "Aisle" : "Window", location: p.even? ? "Front" : "Back", notes: "Test")
			puts "Populating preferences %" + (p*2).to_s + " complete."
		end
	end
end

namespace :db do
	desc "Populates DB with frequent flier clients."
	task :populate_frequent_flier_clients => :environment do
		puts "Populating frequent flier clients"
		client = Client.all
		frequentflier = FrequentFlier.all
		(1..50).each do |ffc|
			client[ffc-1].frequent_flier_clients.create(frequent_flier_id: frequentflier[ffc-1].id)
			puts "Populating frequent flier clients %" + (ffc*2).to_s + " complete."
		end
	end
end

namespace :db do
	desc "Populates the DB with reservations."
	task :populate_reservations => :environment do
		puts "Populating reservations"
		client = Client.all
		agent = Agent.all

		(1..50).each do |r|
			frequentflier = client[r-1].frequent_flier_memberships[0]
			creditcard = client[r-1].credit_cards[0]

			client[r-1].reservations.create(frequent_flier_id: frequentflier.id, credit_card_id: creditcard.id, preference_id: client[r-1].preference.id, status: 0, agent_id: agent[r-1].id)
			puts "Populating reservations %" + (r*2).to_s + " complete."
		end
	end
end

namespace :db do
	desc "Populates the DB with flight reservations."
	task :populate_flight_reservations => :environment do
		puts "Populating flight reservations"
		client = Client.all
		flight = Flight.all
		reservation = Reservation.all

		(0..49).each do |fr|
			reservation[fr].flight_reservations.create(flight_id: flight[fr].id)
			puts "Populating flight reservations %" + (fr*2).to_s + " complete."
		end
	end
end

namespace :db  do
  desc "Populates the DB with flights, frequent flier programs, agents, clients and "
  task :clear_all => :environment do
  	Agent.destroy_all
  	puts "Destroyed all Agents"
  	Client.destroy_all
  	puts "Destroyed all Clients"
  	CreditCard.destroy_all
  	puts "Destroyed all Credit Cards"
  	FlightReservation.destroy_all
  	puts "Destroyed all Flight Reservations"
  	Flight.destroy_all
    puts "Destroyed all Flights"
    FrequentFlierClient.destroy_all
    puts "Destroyed all Frequent Flier Clients"
    FrequentFlier.destroy_all
    puts "Destroyed all Frequent Flier Programs"
    Plane.destroy_all
    puts "Destroyed all Planes"
    Preference.destroy_all
    puts "Destroyed all Preferences"
    Reservation.destroy_all
    puts "Destroyed all Reservations"
    puts "Clear All complete."
  end
end