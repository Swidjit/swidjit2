class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.belongs_to :user
      t.belongs_to :item
      t.float :value
      t.string :message
      t.datetime :expiration
    end
  end
end
