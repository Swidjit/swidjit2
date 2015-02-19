class UsersController < ApplicationController

  def show
    if params.has_key?("display_name")
      @user = User.where(:username=>params[:display_name]).first
    else
      @user = User.find(params[:id])
    end
    if @user.nil?
      @object = "User Profile for #{params[:display_name]}"
      render 'errors/404', :status => 404
    end
    @shared = Item.joins(:reactions).where("#{Reaction.table_name}.item_id = #{Item.table_name}.id AND #{Reaction.table_name}.user_id = ?", @user.id)
  end

  def edit
    if params.has_key?("display_name")
      @user = User.where(:username=>params[:display_name]).first
    else
      @user = User.find(params[:id])
    end
  end

  def upload_file

    current_user.update_attribute(:pic, URI.parse(URI.unescape(params['url'])))
    @user = User.find(params[:id])
  end

end
