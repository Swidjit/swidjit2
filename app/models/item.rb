class Item < ActiveRecord::Base

  belongs_to :user

  has_many :watches
  has_many :notifications
  has_many :images

  acts_as_taggable_on :topic

  after_save :notify, :only => [:update]

  def notify
    n = Notification.new
    n.item = self
    n.action = "updated"
    n.init_user_id = self.user_id
    n.save
  end
end