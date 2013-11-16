class RenamePaymentSourceColumnInReservations < ActiveRecord::Migration
  def up
  	rename_column :reservations, :payment_source, :credit_card_id
  end

  def down
  	rename_column :resrevations, :credit_card_id, :payment_source
  end
end
