# == Schema Information
#
# Table name: flight_reservations
#
#  id             :integer          not null, primary key
#  flight_id      :integer
#  reservation_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class FlightReservationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
