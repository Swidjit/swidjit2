class Freepile < Item
  scope :like_new, -> { where('condition = ?', "new") }
end