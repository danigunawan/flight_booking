class CreatePlanes < ActiveRecord::Migration
  def change
    create_table :planes do |t|
      t.string :manufacturer
      t.string :prop_type
      t.integer :bus_cap
      t.integer :eco_cap
      t.integer :tail_num

      t.timestamps
    end
  end
end
