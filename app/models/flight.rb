class Flight < ActiveRecord::Base
  attr_accessible :airline_id, :arrival, :bus_avail, :bus_fare, :date, :departure, :destination_airport, :eco_avail, :eco_fare, :number, :origin_airport

  has_one :plane
  belongs_to :airline

  validates :airline_id, presence: true
  validates :arrival, presence: true
  validates :bus_fare, presence: true
  validates :eco_fare, presence: true
  validates :date, presence: true
  validates :departure, presence: true
  validates :destination_airport, presence: true
  validates :number, presence: true
  validates :origin_airport, presence: true
end
