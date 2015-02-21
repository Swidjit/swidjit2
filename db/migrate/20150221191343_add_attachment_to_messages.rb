class AddAttachmentToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :attachment_type, :string
    add_column :messages, :attachment_id, :integer
  end
end
