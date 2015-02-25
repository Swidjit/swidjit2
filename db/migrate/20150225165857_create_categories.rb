class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :description
      t.float :rate, :default => 0
      t.string :category_status
    end
  end
end
