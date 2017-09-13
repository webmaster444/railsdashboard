class AddPrivilegeContactinfoToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :contact, :string
    add_column :users, :phone, :string
    add_column :users, :caa, :boolean
    add_column :users, :cua, :boolean
    add_column :users, :pm, :boolean
    add_column :users, :vsd, :boolean
    add_column :users, :eci, :boolean
    add_column :users, :etp, :boolean
  end
end
