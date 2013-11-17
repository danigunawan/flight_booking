# == Schema Information
#
# Table name: reservations
#
#  id                :integer          not null, primary key
#  client_id         :integer
#  credit_card_id    :integer
#  status            :integer
#  preference_id     :integer
#  frequent_flier_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  agent_id          :integer
#

require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
