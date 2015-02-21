class PagesController < ApplicationController

  def home
    @user_posts = current_user.items.map(&:id)
    @claims = Claim.where('item_id in (?) and claim_status in (?)', @user_posts, ["submitted","pending_payment"])
  end

  def index
    @title = params[:page_name].titleize
    render params[:page_name]
  end
end
