class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.belongs_to :item
      t.string :title
      t.text :description
      t.string :image_url
      t.integer :visit_count, :default => 0
      t.string :url
    end
  end
end
