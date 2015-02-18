class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.belongs_to :item, :null => :false
      t.belongs_to :user, :null => :false
      t.integer :rsvp_count, :default => 1
      t.string  :rsvp_type, :null => :false
    end
  end
end
