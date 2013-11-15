class Reservation < ActiveRecord::Base
  attr_accessible :client_id, :frequentflier_id, :payment_source, :preference_id, :status
end
