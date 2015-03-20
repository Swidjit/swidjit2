class Suggestion < ActiveRecord::Base

  belongs_to :user
  belongs_to :request
  has_one :item
end
