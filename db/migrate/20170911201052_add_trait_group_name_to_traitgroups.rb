class AddTraitGroupNameToTraitgroups < ActiveRecord::Migration[5.1]
  def change
    add_column :traitgroups, :trait_group_name, :string
  end
end
