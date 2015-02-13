class CreateImage < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.belongs_to :item
    end
  end
end
