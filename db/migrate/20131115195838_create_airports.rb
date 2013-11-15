class CreateAirports < ActiveRecord::Migration
  def change
    create_table :airports do |t|
      t.string :i_code
      t.string :name
      t.string :country
      t.string :city
      t.integer :phone

      t.timestamps
    end
  end
end
