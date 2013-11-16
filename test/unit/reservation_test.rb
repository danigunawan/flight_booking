# == Schema Information
#
# Table name: reservations
#
#  id               :integer          not null, primary key
#  client_id        :integer
#  payment_source   :integer
#  status           :integer
#  preference_id    :integer
#  frequentflier_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
