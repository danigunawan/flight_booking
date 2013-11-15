class CreateFrequentFlierClients < ActiveRecord::Migration
  def change
    create_table :frequent_flier_clients do |t|
      t.integer :frequentflier_id
      t.integer :client_id

      t.timestamps
    end

    add_index :frequent_flier_clients, :frequentflier_id
    add_index :frequent_flier_clients, :client_id
    add_index :frequent_flier_clients, [:frequentflier_id, :client_id], unique: true
  end
end
