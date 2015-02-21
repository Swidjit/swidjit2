class PagesController < ApplicationController

  def home
    #@users = current_user.subscriptions.collect(&:subscription_id)
    #@items = Item.by_users(@users)
    #@items = Item.max_cost(20)
    #@items = Item.flagged
    #@items = Item.having_image
    @tag = params[:topic]
    @items = Item.all
    if user_signed_in?
      @user_posts = current_user.items.map(&:id)
      @claimed = Claim.where('item_id in (?) and claim_status in (?)', @user_posts, ["submitted","pending_payment"])
      @claims = current_user.claims.where('claim_status in (?)', ["submitted","pending_payment"])
    end
  end

  def index
    @title = params[:page_name].titleize
    render params[:page_name]
  end
end
