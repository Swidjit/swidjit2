class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.belongs_to :user
      t.datetime :start_date
      t.datetime :end_date
      t.string :invoice_status
      t.float :value
      t.string :currency
      t.timestamps
    end
  end
end
