class RenameAirpAirlTable < ActiveRecord::Migration
  def up
  	rename_table :airp_airls, :airport_airlines
  end

  def down
  	rename_table :airport_airlines, :airp_airls
  end
end
