# == Schema Information
#
# Table name: credit_cards
#
#  id         :integer          not null, primary key
#  client_id  :integer
#  number     :integer
#  cvv2       :integer
#  expiration :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class CreditCardTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
