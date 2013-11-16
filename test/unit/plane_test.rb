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

require 'test_helper'

class PlaneTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
