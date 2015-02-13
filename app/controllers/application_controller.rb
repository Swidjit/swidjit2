class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :get_notifications

  def get_notifications
    if user_signed_in?
      @watching = current_user.watches.map(&:item_id)
      @notifications = Notification.where(:item_id => @watching)
    end
  end
end
