class CreateSwapOffers < ActiveRecord::Migration
  def change
    create_table :swap_offers do |t|
      t.text :productsA, array: true, default: []
      t.text :productsB, array: true, default: []
      t.text :comment
      t.belongs_to :userA
      t.belongs_to :userB
      t.datetime :expiration
      t.timestamps
    end
  end
end
