class CreateFlags < ActiveRecord::Migration
  def change
    create_table :flags do |t|
      t.belongs_to :item
      t.belongs_to :user
      t.integer :flagged_by, :null =>:false
      t.integer :term, :null=>:false
      t.string :term_type, :null=>:false
      t.string :comment
    end
  end
end
