class Preference < ActiveRecord::Base
  attr_accessible :client_id, :location, :notes, :seat
end
