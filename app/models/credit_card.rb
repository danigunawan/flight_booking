# == Schema Information
#
# Table name: credit_cards
#
#  id             :integer          not null, primary key
#  client_id      :integer
#  number         :integer
#  cvv2           :integer
#  expiration     :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  reservation_id :integer
#

class CreditCard < ActiveRecord::Base
  attr_accessible :cvv2, :expiration, :number

  belongs_to :client
  has_many :reservations, through: :client

  validates :cvv2, presence: true
  validates :expiration, presence: true
  validates :number, presence: true
  validates :client_id, presence: true
end
