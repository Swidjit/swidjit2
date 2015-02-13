class CreateItem < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.belongs_to :user
      t.string :type
      t.string :title
      t.string :details
      t.integer :category_id
      t.datetime :expiration
      t.datetime :start_time
      t.datetime :end_time
      t.string :address
      t.string :latlng
      t.integer :importance, :default => 0
      t.string :publish_status
      t.string :condition
    end
  end
end
