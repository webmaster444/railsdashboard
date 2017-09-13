class AddSourcefileToMap < ActiveRecord::Migration[5.1]
  def change
    add_column :maps, :sourcefile, :attachment
  end
end
