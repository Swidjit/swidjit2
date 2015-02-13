class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.belongs_to :item
      t.string :action
      t.integer :importance, :default => 0
      t.integer :init_user_id
      t.boolean :read, :default => "false"
      t.timestamps
    end
  end
end
