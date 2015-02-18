class RsvpsController < ApplicationController
  respond_to :js

  def create
    @item = Item.unscoped.find(params[:item_id])
    @rsvp = Rsvp.new(:rsvp_type=> params[:rsvp][:rsvp_type], :rsvp_count => params[:rsvp][:rsvp_count], :user_id => current_user.id)
    @item.rsvps << @rsvp
  end

  def destroy
     @rsvp = Rsvp.find(params[:id])
     @rsvp.destroy
  end

end
