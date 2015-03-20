class AddRequestIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :request_id, :integer
  end
end
