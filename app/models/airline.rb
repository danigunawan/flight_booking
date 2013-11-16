# == Schema Information
#
# Table name: airlines
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  phone      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Airline < ActiveRecord::Base
  attr_accessible :name, :phone

  has_many :airport_airlines, foreign_key: "airline_id"
  has_many :airports, through: :airport_airlines
  has_many :flights
  has_one :frequent_flier

  validates :name, presence: true
  validates :phone, presence: true
end
