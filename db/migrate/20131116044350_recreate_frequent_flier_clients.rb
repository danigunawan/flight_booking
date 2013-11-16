class RecreateFrequentFlierClients < ActiveRecord::Migration
  def up
    create_table :frequent_flier_clients do |t|
      t.integer :frequent_flier_id
      t.integer :client_id

      t.timestamps
    end

    add_index :frequent_flier_clients, :frequent_flier_id
    add_index :frequent_flier_clients, :client_id
    add_index :frequent_flier_clients, [:frequent_flier_id, :client_id], unique: true
  end

  def down
  	drop_table :frequent_flier_clients
  end
end
