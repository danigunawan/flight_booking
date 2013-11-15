class CreateAirpAirls < ActiveRecord::Migration
  def change
    create_table :airp_airls do |t|
      t.integer :airport_id
      t.integer :airline_id

      t.timestamps
    end

    add_index :airp_airls, :airport_id
    add_index :airp_airls, :airline_id
    add_index :airp_airls, [:airport_id, :airline_id], unique: true
  end
end
