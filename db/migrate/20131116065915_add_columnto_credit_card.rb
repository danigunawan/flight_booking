class AddColumntoCreditCard < ActiveRecord::Migration
  def up
  	add_column :credit_cards, :reservation_id, :integer
  end

  def down
  	remove_column :credit_cards, :reservation_id
  end
end
