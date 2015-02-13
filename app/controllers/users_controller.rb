class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @shared = Item.joins(:reactions).where("#{Reaction.table_name}.item_id = #{Item.table_name}.id AND #{Reaction.table_name}.user_id = ?", @user.id)
  end
end
