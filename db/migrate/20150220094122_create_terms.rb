class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :title, :null=>:false
      t.string :description, :null=>:false
      t.string :term_type, :null=>:false
    end
  end
end
