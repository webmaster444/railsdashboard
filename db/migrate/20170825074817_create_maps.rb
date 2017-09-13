class CreateMaps < ActiveRecord::Migration[5.1]
  def change
    create_table :maps do |t|
      t.string :maptitle
      t.integer :datapoints

      t.timestamps
    end
  end
end
