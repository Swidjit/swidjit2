class Request < ActiveRecord::Base

  belongs_to :user
  acts_as_commentable

  def suggestions
    Item.where(:request_id => self.id)
  end
end
