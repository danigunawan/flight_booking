class AirpAirl < ActiveRecord::Base
  attr_accessible :airline_id, :airport_id

  belongs_to :airline, class_name: "Airline"
  belongs_to :airport, class_name: "Airport"
end
