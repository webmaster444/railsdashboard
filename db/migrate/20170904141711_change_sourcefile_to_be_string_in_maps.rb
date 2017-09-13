class ChangeSourcefileToBeStringInMaps < ActiveRecord::Migration[5.1]
  def change
  	change_column :maps, :sourcefile, :string
  end
end
