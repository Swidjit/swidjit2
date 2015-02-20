class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.belongs_to :user
      t.belongs_to :item
      t.integer :value
      t.string :currency
      t.string :message
      t.datetime :expiration
    end
  end
end
