class CreateFrequentFliers < ActiveRecord::Migration
  def change
    create_table :frequent_fliers do |t|
      t.integer :airline_id
      t.integer :discount

      t.timestamps
    end
  end
end
