class FrequentFlierClient < ActiveRecord::Base
  attr_accessible :client_id, :frequent_flier_id

  belongs_to :frequent_flier, class_name: "FrequentFlier"
  belongs_to :client, class_name: "Client"

  validates :client_id, presence: true
  validates :frequent_flier_id, presence: true
end
