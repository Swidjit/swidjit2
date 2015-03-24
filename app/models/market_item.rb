class MarketItem < Item
  has_many :offers, :dependent => :delete_all, :foreign_key => :item_id
end