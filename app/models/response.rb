class Response < ActiveRecord::Base

  belongs_to :question
  belongs_to :item
  belongs_to :user

end