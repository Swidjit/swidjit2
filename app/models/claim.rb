class Claim < ActiveRecord::Base
  belongs_to :item
  belongs_to :user
  after_save :notify, :only => [:accept]



  def notify
    n = Notification.new
    n.item = self.item
    n.action = "claimed"
    n.init_user_id = self.user_id
    n.save
  end
end
