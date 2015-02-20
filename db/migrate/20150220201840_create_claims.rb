class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.belongs_to :item, :null => :false
      t.belongs_to :user, :null => :false
      t.string :claim_status, :null => :false, :default => "submitted"

    end
  end
end
