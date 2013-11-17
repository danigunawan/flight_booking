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

  belongs_to :flight, class_name: "Flight"
  belongs_to :reservation, class_name: "Reservation"

  validates :flight_id, presence: true
  validates :reservation_id, presence: true
end
