class Request < ActiveRecord::Base

  belongs_to :user
  has_many :suggestions
  acts_as_commentable
end
