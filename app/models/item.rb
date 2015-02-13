class Item < ActiveRecord::Base

  belongs_to :user

  has_many :watches, :dependent => :delete_all
  has_many :notifications, :dependent => :delete_all
  has_many :images, :dependent => :delete_all
  has_many :reactions, :dependent => :delete_all

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