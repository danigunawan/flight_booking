# == Schema Information
#
# Table name: planes
#
#  id           :integer          not null, primary key
#  manufacturer :string(255)
#  prop_type    :string(255)
#  bus_cap      :integer
#  eco_cap      :integer
#  tail_num     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  flight_id    :integer
#  type         :string(255)
#

class Plane < ActiveRecord::Base
  attr_accessible :bus_cap, :eco_cap, :manufacturer, :prop_type, :tail_num, :type

  belongs_to :flight

  validates :bus_cap, presence: true
  validates :eco_cap, presence: true
  validates :manufacturer, presence: true
  validates :type, presence: true
  validates :prop_type, presence: true
  validates :tail_num, presence: true
  validates :flight_id, presence: true
end
