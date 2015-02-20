class Item < ActiveRecord::Base

  belongs_to :user

  has_many :watches, :dependent => :delete_all
  has_many :notifications, :dependent => :delete_all
  has_many :images, :dependent => :delete_all
  has_many :reactions, :dependent => :delete_all
  has_many :recurrences, :dependent => :destroy, :foreign_key => :item_id
  has_many :occurrences, :dependent => :destroy, :foreign_key => :item_id
  has_many :rsvps, :dependent => :destroy
  has_many :spots, :dependent => :destroy
  has_many :flags, :dependent => :destroy
  accepts_nested_attributes_for :spots
  accepts_nested_attributes_for :recurrences

  acts_as_commentable

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