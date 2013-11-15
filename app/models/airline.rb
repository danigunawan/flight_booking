class Airline < ActiveRecord::Base
  attr_accessible :name, :phone

  has_many :airp_airl, foreign_key: "airline_id"
end
