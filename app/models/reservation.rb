# == Schema Information
#
# Table name: reservations
#
#  id                :integer          not null, primary key
#  client_id         :integer
#  payment_source    :integer
#  status            :integer
#  preference_id     :integer
#  frequent_flier_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Reservation < ActiveRecord::Base
	#credit_card_id is a hack, this should be a polymorphic association.
  attr_accessible :frequent_flier_id, :preference_id, :credit_card_id, :status

  belongs_to :client
  belongs_to :credit_card

  validates :client_id, presence: true
  validates :frequent_flier_id, presence: true
  validates :credit_card_id, presence: true
  validates :preference_id, presence: true
  validates :status, presence: true
end
