class WatchesController < ApplicationController
  respond_to :js

  def create
    @watch = Watch.where(:item_id=>params[:item_id], :user_id=>current_user.id)
    if @watch.present?
      @watch.first.destroy
      respond_with do |format|
        format.js {render 'destroy', :locals=>{id:params[:item_id]}}
      end
    else
      @watch = Watch.new(:item_id=>params[:item_id], :user_id=>current_user.id)
      @watch.save
      respond_with do |format|
        format.js {render 'create', :locals=>{id:params[:item_id]}}
      end
    end
  end

end
