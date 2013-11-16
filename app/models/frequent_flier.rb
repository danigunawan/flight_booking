class FrequentFlier < ActiveRecord::Base
  attr_accessible :discount

  belongs_to :airline

  has_many :frequent_flier_clients, foreign_key: "frequent_flier_id"
  has_many :clients, through: :frequent_flier_clients

  validates :airline_id, presence: true
  validates :discount, presence: true
end
