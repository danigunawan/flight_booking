# == Schema Information
#
# Table name: frequent_fliers
#
#  id         :integer          not null, primary key
#  airline_id :integer
#  discount   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class FrequentFlierTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
