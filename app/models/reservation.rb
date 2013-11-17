# == Schema Information
#
# Table name: reservations
#
#  id                :integer          not null, primary key
#  client_id         :integer
#  credit_card_id    :integer
#  status            :integer
#  preference_id     :integer
#  frequent_flier_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  agent_id          :integer
#

class Reservation < ActiveRecord::Base
	#credit_card_id, frequent_flier_id and agent_id all seem hackish. I need a way to do this with the associations.
  attr_accessible :frequent_flier_id, :preference_id, :credit_card_id, :status, :agent_id

  belongs_to :client
  belongs_to :agent

  has_many :flight_reservations, foreign_key: "reservation_id"
  has_many :flights, through: :flight_reservations

  validates :client_id, presence: true
  validates :frequent_flier_id, presence: true
  validates :credit_card_id, presence: true
  validates :preference_id, presence: true
  validates :status, presence: true
  validates :agent_id, presence: true
end
