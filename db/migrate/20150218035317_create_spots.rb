class CreateSpots < ActiveRecord::Migration
  def change
    create_table :spots do |t|
      t.belongs_to :item
      t.string :spot_type
      t.integer :spot_count
    end
  end
end
