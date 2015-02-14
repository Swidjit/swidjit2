class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.belongs_to :user, :null => :false
      t.belongs_to :question, :null => :false
      t.belongs_to :answer, :null => :false
      t.timestamps
    end
  end
end
