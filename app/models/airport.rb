class Airport < ActiveRecord::Base
  attr_accessible :city, :country, :i_code, :name, :phone
end
