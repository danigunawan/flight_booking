# == Schema Information
#
# Table name: credit_cards
#
#  id         :integer          not null, primary key
#  client_id  :integer
#  number     :integer
#  cvv2       :integer
#  expiration :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CreditCard < ActiveRecord::Base
  attr_accessible :cvv2, :expiration, :number, :owner_id
end
