class CreateTraitgroups < ActiveRecord::Migration[5.1]
  def change
    create_table :traitgroups do |t|
      t.string :traitgroup

      t.timestamps
    end
  end
end
