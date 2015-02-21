class AddLatLngToItems < ActiveRecord::Migration
  def change
    add_column :items, :latitude, :float
    add_column :items, :longitude, :float
    remove_column :items, :latlng
  end
end
