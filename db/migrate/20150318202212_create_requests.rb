class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.belongs_to :user
      t.string :item_type, :null => :false
      t.string :title, :null => :false
      t.string :body, :null => :false
      t.timestamps
    end
  end
end
