class AddTraitIdToMaps < ActiveRecord::Migration[5.1]
  def change
    add_column :maps, :trait_id, :int
  end
end
