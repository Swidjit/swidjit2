class Claim < ActiveRecord::Base
  belongs_to :item
  belongs_to :user
  after_save :notify, :only => [:accept]
  after_save :message_item_owner

  def message_item_owner

    if self.claim_status == "submitted"
      message = "someone has placed a claim on your item #{self.item.title}.  please take quick action to accept or deny claim"
      conversation = Conversation.create(:user_id => 1, :recipient_id => self.item.user.id)
      Message.create(:conversation_id => conversation.id, :user_id => 1, :body => message, :attachment_type => self.class.to_s, :attachment_id => self.id)
    elsif self.claim_status == "pending_payment"
      message = "#{self.item.user.username} has accepted you claim on your item #{self.item.title}, pending payment"
      conversation = Conversation.create(:user_id => 1, :recipient_id => self.user.id)
      Message.create(:conversation_id => conversation.id, :user_id => 1, :body => message)
    elsif self.claim_status == "accepted"
      puts self
      message = "#{self.item.user.username} has accepted you claim on your item #{self.item.title}.  Get in touch soon to arrange for transfer."
      conversation = Conversation.create(:user_id => 1, :recipient_id => self.user.id)
      Message.create(:conversation_id => conversation.id, :user_id => 1, :body => message)
    end
  end

  def notify
    n = Notification.new
    n.item = self.item
    n.action = "claimed"
    n.init_user_id = self.user_id
    n.save
  end
end
