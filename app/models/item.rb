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
  has_many :claims, :dependent => :delete_all
  accepts_nested_attributes_for :spots
  accepts_nested_attributes_for :recurrences
  has_many :prices, :dependent => :delete_all, :foreign_key => :item_id
  geocoded_by :address   # can also be an IP address
  after_validation :geocode
  accepts_nested_attributes_for :prices
  acts_as_commentable

  acts_as_taggable_on :topic

  after_save :notify, :only => [:update]
  after_save :add_transaction, :only => [:create]
  before_save :notify_requester, if: :request_id_changed?

  scope :status, -> (status) { where publish_status: status }
  scope :popular, ->  { order(importance: :desc) }
  scope :happening_soon, -> { order(start_time: :asc)}
  scope :by_users, -> (users) {where('items.user_id in (?)',users)}
  scope :max_cost, -> (cost) {joins(:prices).where("prices.value < ?", cost)}
  scope :flagged, -> {joins(:flags)}
  scope :having_image, -> {joins(:images)}

  #most commented
  #having similiar tags
  #located nearby
  #matching interests

  def add_transaction
    puts 'jhey'
    puts self.class
    puts self
    puts self.user
    puts user
    if self.class == Event
      t = Transaction.new
      t.value = 0.05
      t.currency = "usd"
      t.item_id = self.id
      t.user_id = self.user.id
      t.category_id = 3
      t.reason = "posting"
      t.transaction_status = "unpaid"
      t.save
    end
  end

  def notify
    n = Notification.new
    n.item = self
    n.action = "updated"
    n.init_user_id = self.user_id
    n.save
  end

  def notify_requester
    puts "request"
    n = Notification.new
    n.item = self
    n.action = "suggested"
    n.init_user_id = self.user_id
    n.save
  end

end