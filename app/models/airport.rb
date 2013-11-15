class Airport < ActiveRecord::Base
  attr_accessible :city, :country, :i_code, :name, :phone

  has_many :airp_airl, foreign_key: "airport_id"

  validates :city, presence: true
  validates :country, presence: true
  validates :i_code, presence: true
  validates :name, presence: true
  validates :phone, presence: true
end
