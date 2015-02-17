class CreateOccurrences < ActiveRecord::Migration
  def change
    create_table :occurrences do |t|
      t.belongs_to :item
      t.datetime :dt, :null => :false
    end
  end
end
