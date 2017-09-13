class AddTraitgroupsIdToMaps < ActiveRecord::Migration[5.1]
  def change
    add_column :maps, :traitgroups_id, :string
  end
end
