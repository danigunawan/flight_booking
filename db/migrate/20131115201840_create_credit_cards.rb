class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.integer :client_id
      t.integer :number
      t.integer :cvv2
      t.date :expiration

      t.timestamps
    end
  end
end
