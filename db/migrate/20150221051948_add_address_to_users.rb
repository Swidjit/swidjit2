class AddAddressToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_name, :string
    add_column :users, :address, :string
    add_column :users, :latlng, :string
  end
end
