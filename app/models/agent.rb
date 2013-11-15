class Agent < ActiveRecord::Base
  attr_accessible :end_date, :name, :reservation_id, :start_date, :status
end
