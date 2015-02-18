class RsvpsController < ApplicationController
  respond_to :js

  def create
    @item = Item.unscoped.find(params[:item_id])
    @spots = @item.spots.where(:spot_type => params[:rsvp][:rsvp_type]).first
    if @spots.present?
      @rsvp_count = @item.rsvps.where(:rsvp_type => params[:rsvp][:rsvp_type]).sum(:rsvp_count)
      if @spots.spot_count >= (@rsvp_count + params[:rsvp][:rsvp_count].to_i)
        @rsvp = Rsvp.new(:rsvp_type=> params[:rsvp][:rsvp_type], :rsvp_count => params[:rsvp][:rsvp_count], :user_id => current_user.id)
        @item.rsvps << @rsvp
      else
        respond_to do |format|
          format.js {render 'create_failed'}
        end

      end
    else
       respond_to do |format|
        format.js {render 'create_failed'}
      end
    end

  end

  def destroy
     @rsvp = Rsvp.find(params[:id])
     @rsvp.destroy
  end

end
