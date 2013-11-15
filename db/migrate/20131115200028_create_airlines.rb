class CreateAirlines < ActiveRecord::Migration
  def change
    create_table :airlines do |t|
      t.string :name
      t.integer :phone

      t.timestamps
    end
  end
end
