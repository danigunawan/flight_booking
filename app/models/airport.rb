class Airport < ActiveRecord::Base
  attr_accessible :city, :country, :i_code, :name, :phone

  has_many :airp_airl, foreign_key: "airport_id"
end
