class CommentsController < ApplicationController

  def create
    item = Comment.create(item_params)
    current_user.items << item
    item.topic_list = item_params[:topic_list]
    item.save

  end

  def new
    @comment = Comment.new
  end

  def item_params
    params.require(:comment).permit(:details, :topic_list)
  end

  def index
    @comments = Comment.all
    puts @comments
  end

end
