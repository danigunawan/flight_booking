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

class Flight < ActiveRecord::Base
  attr_accessible :airline_id, :arrival, :bus_avail, :bus_fare, :date, :departure, :destination_airport, :eco_avail, :eco_fare, :number, :origin_airport

  has_one :plane
  belongs_to :airline

  has_many :flight_reservations, foreign_key: "flight_id"
  has_many :reservations, through: :flight_reservations

  validates :airline_id, presence: true
  validates :arrival, presence: true
  validates :bus_fare, presence: true
  validates :eco_fare, presence: true
  validates :date, presence: true
  validates :departure, presence: true
  validates :destination_airport, presence: true
  validates :number, presence: true
  validates :origin_airport, presence: true

  def set_seat_count(plane)
    self.eco_avail = plane.eco_cap
    self.bus_avail = plane.bus_cap
    self.save
  end
end
