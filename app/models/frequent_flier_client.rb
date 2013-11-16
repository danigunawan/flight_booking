# == Schema Information
#
# Table name: frequent_flier_clients
#
#  id                :integer          not null, primary key
#  frequent_flier_id :integer
#  client_id         :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class FrequentFlierClient < ActiveRecord::Base
  attr_accessible :client_id, :frequent_flier_id

  belongs_to :frequent_flier, class_name: "FrequentFlier"
  belongs_to :client, class_name: "Client"

  validates :client_id, presence: true
  validates :frequent_flier_id, presence: true
end
