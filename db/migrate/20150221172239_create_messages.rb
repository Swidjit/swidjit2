class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.belongs_to :user
      t.belongs_to :conversation
      t.string :body
      t.boolean :read
      t.timestamps
    end
  end
end
