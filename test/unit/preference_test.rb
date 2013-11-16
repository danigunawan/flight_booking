# == Schema Information
#
# Table name: preferences
#
#  id         :integer          not null, primary key
#  client_id  :integer
#  location   :string(255)
#  seat       :string(255)
#  notes      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class PreferenceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
