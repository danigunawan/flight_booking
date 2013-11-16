class Client < ActiveRecord::Base
  attr_accessible :address, :name, :phone

  has_many :frequent_flier_clients, foreign_key: "client_id"
  has_many :frequent_flier_memberships, through: :frequent_flier_clients, source: :frequent_flier

  validates :address, presence: true
  validates :name, presence: true
  validates :phone, presence: true
end
