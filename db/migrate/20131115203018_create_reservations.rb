class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :client_id
      t.integer :payment_source
      t.integer :status
      t.integer :preference_id
      t.integer :frequentflier_id

      t.timestamps
    end
  end
end
