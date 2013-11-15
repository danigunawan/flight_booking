class CreditCard < ActiveRecord::Base
  attr_accessible :cvv2, :expiration, :number, :owner_id
end
