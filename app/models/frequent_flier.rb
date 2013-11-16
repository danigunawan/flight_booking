class FrequentFlier < ActiveRecord::Base
  attr_accessible :discount

  belongs_to :airline

  validates :airline_id, presence: true
  validates :discount, presence: true
end
