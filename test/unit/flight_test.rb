# == Schema Information
#
# Table name: flights
#
#  id                  :integer          not null, primary key
#  airline_id          :integer
#  number              :integer
#  date                :date
#  departure           :datetime
#  arrival             :datetime
#  origin_airport      :integer
#  destination_airport :integer
#  bus_fare            :integer
#  eco_fare            :integer
#  bus_avail           :integer
#  eco_avail           :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'test_helper'

class FlightTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
