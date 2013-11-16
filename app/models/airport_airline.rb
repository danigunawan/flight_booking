class AirportAirline < ActiveRecord::Base
  attr_accessible :airline_id, :airport_id

  belongs_to :airline, class_name: "Airline"
  belongs_to :airport, class_name: "Airport"

  validates :airline_id, presence: true
  validates :airport_id, presence: true
end
