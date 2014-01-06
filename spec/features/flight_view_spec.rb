require 'spec_helper'

describe "FlightPage" do

	let(:airline) {FactoryGirl.create(:airline, :set_name => "Virgin America")}
	let(:airport1) {FactoryGirl.create(:airport, :set_name => "San Francisco International Airport")}
	let(:airport2) {FactoryGirl.create(:airport, :set_name => "Los Angeles International Airport")}
	let(:flight) {FactoryGirl.create(:flight, airline: airline, set_destination_airport: airport2.id, set_origin_airport: airport1.id, set_number: 202, set_bus_fare: 500, set_eco_fare: 250)}
	let!(:plane) {FactoryGirl.create(:plane, flight: flight)}

	subject {page}

	before do
		visit root_path	
	end

	
	describe "drop down box" do
		it "should have a div of class dropdowns" do
			should have_selector('div.dropdowns')
		end

		it "should contain a select with id 'airline_select'" do
			should have_selector('select#airline_select')
		end

		it "should contain a select with id 'origin_select'" do
			should have_selector('select#origin_select')
		end

		it "should contain a select with id 'dest_select'" do
			should have_selector('select#dest_select')
		end

		it "should contain a select with id 'price_select'" do
			should have_selector('select#price_select')
		end

		it "should contain an input with id 'select_date'" do
			should have_selector('input#select_date')
		end

		it "should contain a select with id 'min_seats'" do
			should have_selector('select#min_seats')
		end
	end

	describe "airline_select" do
		it "should contain a default option for 'all airlines'" do
			page.has_select?('airline_select', :with_options => ['All Airlines'])
		end

		it "should contain an option for each airline" do
			page.has_select?('airline_select', :with_options => [airline.name])
		end
	end

	describe "flight table" do
		it "should contain a div with id 'flight_table'" do
			should have_selector('div#flight_table')
		end

		it "should render _flight_table" do
			should have_selector('tbody#flight_table_tbody')
		end

		describe "table head" do
			it "should have a th with id 'airline'" do
				should have_selector('th#airline')
			end

			it "should have a th with id 'origin'" do
				should have_selector('th#origin')
			end

			it "should have a th with id 'destination'" do
				should have_selector('th#destination')
			end

			it "should have a th with id 'departure_info'" do
				should have_selector('th#departure_info')
			end

			it "should have a th with id 'arrival_info'" do
				should have_selector('th#arrival_info')
			end

			it "should have a th with id 'seats_avail'" do
				should have_selector('th#seats_avail')
			end

			it "should have a th with id 'price'" do
				should have_selector('th#price')
			end

			it "should have a th with id 'reservation_column'" do
				should have_selector('th#reservation_column')
			end
		end

		describe "table rows" do
			it "should have a tr with id 'flight0'" do
				should have_selector('tr#flight0')
			end

			it "should have a tr with data-flight-id == to flight.id" do
				should have_selector("tr#flight0[data-flight-id='#{flight.id}']")
			end

			it "should have a td with id '0airline' and text of Virgin America" do
				should have_selector('td#0airline', text: 'Virgin America')
			end

			it "should have a td with id '0origin' and text of San Francisco International Airport" do
				should have_selector('td#0origin', text: 'San Francisco International Airport')
			end

			it "should have a td with id '0destination' and text of Los Angeles International Airport" do
				should have_selector('td#0destination', text: 'Los Angeles International Airport')
			end

			it "should have a td with id '0departure_info' and text matching @time_now + 1" do
				should have_selector('td#0departure_info', text: '2013-02-03 17:05:06 UTC')
			end

			it "should have a td with id '0arrival_info' and text matching @time_now + 5 hours" do
				should have_selector('td#0arrival_info', text: '2013-02-03 21:05:06 UTC')
				#should have_selector('td#0arrival_info', text: (@time_now+(5/24.0)).to_time.ctime)
			end

			it "should have a td with id '0seats_avail and text of '162'" do
				should have_selector('td#0seats_avail', text: 162)
			end

			it "should have a td with id '0price' and text of '250'" do
				should have_selector('td#0price', text: 250)
			end


			describe "when economy seats aren't available but business are" do

				before do
					flight.eco_avail = 0
					flight.save
					visit root_path
				end

				it "should list the lowest price based on seats availability" do
					should have_selector('td#0price', text: 500)
				end
			end

			it "should have a td with id '0reservation' and reservation button" do
				should have_selector('td#0reservation')
				should have_selector('td#0reservation button.btn', text: "Reserve Flight")
			end
		end
	end

	describe "javascript" do
		let(:airline2) {FactoryGirl.create(:airline)}
		let(:airport3) {FactoryGirl.create(:airport)}
		let(:airport4) {FactoryGirl.create(:airport)}
		let(:flight2) {FactoryGirl.create(:flight, airline: airline2, set_destination_airport: airport4.id, set_origin_airport: airport3.id, set_number: 202, set_bus_fare: 500, set_eco_fare: 300)}
		let!(:plane2) {FactoryGirl.create(:plane, flight: flight2)}

		let(:airline3) {FactoryGirl.create(:airline)}
		let(:airport5) {FactoryGirl.create(:airport)}
		let(:airport6) {FactoryGirl.create(:airport)}
		let(:flight3) {FactoryGirl.create(:flight, airline: airline3, set_destination_airport: airport6.id, set_origin_airport: airport5.id, set_number: 202, set_bus_fare: 500, set_eco_fare: 400)}
		let!(:plane3) {FactoryGirl.create(:plane, flight: flight3, set_eco_cap: 1, set_bus_cap: 1)}
		let(:flight4) {FactoryGirl.create(:flight, airline: airline3, set_destination_airport: airport6.id, set_origin_airport: airport5.id, set_number: 202, set_bus_fare: 500, set_eco_fare: 350)}
		let!(:plane4) {FactoryGirl.create(:plane, flight: flight4, set_eco_cap: 1, set_bus_cap: 0)}
		let(:flight5) {FactoryGirl.create(:flight, airline: airline3, set_destination_airport: airport6.id, set_origin_airport: airport5.id, set_number: 202, set_bus_fare: 500, set_eco_fare: 350, set_date: Date.today)}
		let!(:plane5) {FactoryGirl.create(:plane, flight: flight5, set_eco_cap: 1, set_bus_cap: 0)}
		let(:flight6) {FactoryGirl.create(:flight, airline: airline3, set_destination_airport: airport5.id, set_origin_airport: airport6.id, set_number: 202, set_bus_fare: 500, set_eco_fare: 350, set_date: Date.today)}
		let!(:plane6) {FactoryGirl.create(:plane, flight: flight6, set_eco_cap: 1, set_bus_cap: 3)}

		before(:each) do
			visit root_path
		end

		it "selecting an airline from #airline_select should display only flights from that airline", js: true do
			select "#{airline.name}", :from => "airline_select"
			#capybara select does not trigger change events, so the change event must be forced.
			#Source: http://stackoverflow.com/a/8568382
			page.execute_script('$("#airline_select").trigger("change")')
			
			should_not have_selector('td', text: "#{airline2.name}")
			should have_selector('td', text: "#{airline.name}")
		end

		it "selecting an origin airport from #origin_select should display only flights starting at that airport", js: true do
			select "#{airport3.name}", :from => "origin_select"
			page.execute_script('$("#origin_select").trigger("change")')

			should_not have_selector('td', text: "#{airline.name}")
			should have_selector('td', text: "#{airline2.name}")
		end

		it "selecting a destination airport from #dest_select should display only flights ending at that airport", js: true do
			select "#{airport4.name}", :from => "dest_select"
			execute_script('$("#dest_select").trigger("change")')

			should_not have_selector('td', text: "#{airline.name}")
			should have_selector('td', text: "#{airline2.name}")
		end

		it "selecting a minimum seat count from #min_seats should display only flights with that many or more seats", js: true do
			select "2", :from => "min_seats"
			execute_script('$("#min_seats").trigger("change")')

			should_not have_selector("tr[data-flight-id='#{flight4.id}']")
			should have_selector("tr[data-flight-id='#{flight2.id}']")
			should have_selector("tr[data-flight-id='#{flight3.id}']")
		end

		it "selecting a price should display only flights with prices cheaper or equal to it", js: true do
			select "300", :from => "price_select"
			execute_script('$("#price_select").trigger("change")')

			should_not have_selector("tr[data-flight-id='#{flight3.id}']")
			should_not have_selector("tr[data-flight-id='#{flight4.id}']")

			should have_selector("tr[data-flight-id='#{flight2.id}']")
			should have_selector("tr[data-flight-id='#{flight.id}']")
		end

		it "datepicker should not be visible", js: true do
			should_not have_selector("#ui-datepicker-div")
		end

		it "clicking on #select_date should display #date_picker", js: true do
			find('#select_date').click
			should have_selector("#ui-datepicker-div", visible: true)
		end

		it "filling in #select_date with datepicker should display flights on that date", js: true do

			find('#select_date').click

			should have_selector(".ui-state-default", text: "6")
			first('a.ui-state-default', text: Date.today.day).click
			execute_script('$("#select_date").trigger("change")')

			should_not have_selector("tr[data-flight-id='#{flight2.id}']")
			should have_selector("tr[data-flight-id='#{flight5.id}']")
		end

		it "javascript functionality should persist through re-rendered partials", js: true do
			find('#select_date').click

			should have_selector(".ui-state-default", text: "6")
			first('a.ui-state-default', text: Date.today.day).click
			execute_script('$("#select_date").trigger("change")')

			should have_selector("tr[data-flight-id='#{flight6.id}']")
			should have_selector("tr[data-flight-id='#{flight5.id}']")

			should have_selector("#min_seats")
			select "2", :from => "min_seats"
			execute_script('$("#min_seats").trigger("change")')

			should_not have_selector("tr[data-flight-id='#{flight5.id}']")
			should have_selector("tr[data-flight-id='#{flight6.id}']")
		end

		it "after selecting from a drop down, the 'All' value should be available as an option", js: true do
			select "#{airport6.name}", :from => "dest_select"
			execute_script('$("#dest_select").trigger("change")')

			should_not have_selector("tr[data-flight-id='#{flight6.id}']")

			within '#dest_select' do
				should have_css("option[value='All']")
				should_not have_css("option[value='All'][disabled]")
			end

			select "All", :from => "dest_select"
			execute_script('$("#dest_select").trigger("change")')

			should have_selector("tr[data-flight-id='#{flight6.id}']")
		end		
	end
end