class Transfer < ActiveRecord::Base

  belongs_to :recipient, :class_name => 'User'
  belongs_to :sender, :class_name => 'User'
  belongs_to :item

  after_create :transfer_balance

  def transfer_balance
    @payee_balance = Balance.where(:currency=>self.currency, :user_id => self.recipient.id).first
    @payer_balance = Balance.where(:currency=>self.currency, :user_id => self.sender.id).first
    @payee_balance.increment!(:value, self.value)
    @payer_balance.decrement!(:value, self.value)
  end

end
