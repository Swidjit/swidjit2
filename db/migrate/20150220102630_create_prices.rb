class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.belongs_to :item
      t.string :currency
      t.integer :value
      t.boolean :negotiable
      t.boolean :digital_payment
    end
  end
end
