class Product < Item
  has_many :offers, :dependent => :delete_all
  has_many :prices, :dependent => :delete_all, :foreign_key => :item_id

  accepts_nested_attributes_for :prices
end