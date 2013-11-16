class AddTypeColumnToPlanes < ActiveRecord::Migration
  def up
  	add_column :planes, :type, :string
  end
  def down
  	remove_column :planes, :type
  end
end
