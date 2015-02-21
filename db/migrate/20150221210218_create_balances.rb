class CreateBalances < ActiveRecord::Migration
  def change
    create_table :balances do |t|
      t.belongs_to :user
      t.integer :value, :null => :false
      t.string :currency, :null => :false
    end
  end
end
