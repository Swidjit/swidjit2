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

  has_many :subscriptions

  has_many :rsvps, :dependent => :delete_all

end
