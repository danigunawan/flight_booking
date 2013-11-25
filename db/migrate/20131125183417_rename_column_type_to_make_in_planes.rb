class RenameColumnTypeToMakeInPlanes < ActiveRecord::Migration
  def up
  	rename_column :planes, :type, :make
  end

  def down
  	rename_column :planes, :make, :type
  end
end
