# == Schema Information
#
# Table name: airports
#
#  id         :integer          not null, primary key
#  i_code     :string(255)
#  name       :string(255)
#  country    :string(255)
#  city       :string(255)
#  phone      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class AirportTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
