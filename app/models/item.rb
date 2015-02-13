class Item < ActiveRecord::Base
  belongs_to :obj, :polymorphic => :true
  belongs_to :user

  has_many :watches
end