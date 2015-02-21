class PagesController < ApplicationController

  def home
    #@users = current_user.subscriptions.collect(&:subscription_id)
    #@items = Item.by_users(@users)
    #@items = Item.max_cost(20)
    #@items = Item.flagged
    #@items = Item.having_image
    @tag = params[:topic]
    @items = Item.all
    #@user_posts = current_user.items.map(&:id)
    #@claims = Claim.where('item_id in (?) and claim_status in (?)', @user_posts, ["submitted","pending_payment"])
  end

  def index
    @title = params[:page_name].titleize
    render params[:page_name]
  end
end
