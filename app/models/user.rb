class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :watches, :dependent => :delete_all
  has_many :items, :dependent => :delete_all
  has_many :reactions, :dependent => :delete_all

  has_many :comments, :dependent => :delete_all
  has_many :responses

  has_many :flags

  has_many :subscriptions

  has_many :rsvps, :dependent => :delete_all

  has_attached_file :pic, :styles => { :medium => "250x250>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :pic, :content_type => /\Aimage\/.*\Z/


  attr_accessor :login

  validates :username,
  :uniqueness => {
    :case_sensitive => false
  }

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
end
