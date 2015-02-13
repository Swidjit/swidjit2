class Item < ActiveRecord::Base
  belongs_to :obj, :polymorphic => :true
  belongs_to :user
end