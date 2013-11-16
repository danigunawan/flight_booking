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

class FlightReservation < ActiveRecord::Base
  attr_accessible :flight_id, :reservation_id
end
