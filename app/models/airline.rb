class Airline < ActiveRecord::Base
  attr_accessible :name, :phone

  has_many :airport_airlines, foreign_key: "airline_id"
  has_many :airports, through: :airport_airlines

  validates :name, presence: true
  validates :phone, presence: true
end
