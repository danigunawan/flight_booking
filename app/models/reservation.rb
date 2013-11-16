# == Schema Information
#
# Table name: reservations
#
#  id               :integer          not null, primary key
#  client_id        :integer
#  payment_source   :integer
#  status           :integer
#  preference_id    :integer
#  frequentflier_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Reservation < ActiveRecord::Base
  attr_accessible :client_id, :frequentflier_id, :payment_source, :preference_id, :status
end
