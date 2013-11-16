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

require 'test_helper'

class AgentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
