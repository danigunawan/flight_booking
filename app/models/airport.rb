class Airport < ActiveRecord::Base
  attr_accessible :city, :country, :i_code, :name, :phone

  has_many :airport_airlines, foreign_key: "airport_id"
  has_many :airlines, through: :airport_airlines

  validates :city, presence: true
  validates :country, presence: true
  validates :i_code, presence: true
  validates :name, presence: true
  validates :phone, presence: true

end
