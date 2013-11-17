# == Schema Information
#
# Table name: agents
#
#  id             :integer          not null, primary key
#  reservation_id :integer
#  name           :string(255)
#  start_date     :date
#  end_date       :date
#  status         :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Agent < ActiveRecord::Base
  attr_accessible :end_date, :name, :start_date, :status

  has_many :reservations

  validates :name, presence: true
  validates :start_date, presence: true
  validates :status, presence: true
end
