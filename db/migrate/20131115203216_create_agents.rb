class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.integer :reservation_id
      t.string :name
      t.date :start_date
      t.date :end_date
      t.integer :status

      t.timestamps
    end
  end
end
