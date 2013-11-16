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

require 'test_helper'

class FrequentFlierClientTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
