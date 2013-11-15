class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.integer :client_id
      t.string :location
      t.string :seat
      t.string :notes

      t.timestamps
    end
  end
end
