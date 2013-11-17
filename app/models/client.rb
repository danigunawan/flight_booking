# == Schema Information
#
# Table name: clients
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  address    :string(255)
#  phone      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Client < ActiveRecord::Base
  attr_accessible :address, :name, :phone

  has_many :frequent_flier_clients, foreign_key: "client_id"
  has_many :frequent_flier_memberships, through: :frequent_flier_clients, source: :frequent_flier
  has_many :credit_cards
  has_many :reservations
  has_one :preference

  validates :address, presence: true
  validates :name, presence: true
  validates :phone, presence: true
end
