class CreateReactions < ActiveRecord::Migration
  def change
    create_table :reactions do |t|
      t.string :reaction_type
      t.belongs_to :user
      t.belongs_to :item
      t.timestamps
    end
  end
end
