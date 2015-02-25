class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.belongs_to :user
      t.belongs_to :category
      t.string :reason
      t.belongs_to :item
      t.float :value
      t.string :currency
      t.string :transaction_status
      t.timestamps
    end
  end
end
