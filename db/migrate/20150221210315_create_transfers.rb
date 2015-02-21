class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.belongs_to :recipient, :null => :false
      t.belongs_to :sender, :null => :false
      t.belongs_to :item
      t.integer :value, :null => :false
      t.string :currency, :null => :false
      t.string :category, :null => :false
      t.string :transfer_status
      t.timestamps
    end
  end
end
