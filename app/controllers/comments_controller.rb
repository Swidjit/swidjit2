class CommentsController < ApplicationController

  def create
    Comment.create(item_params)

  end

  def new
    @comment = Comment.new
  end

  def item_params
    params.require(:comment).permit(:details)
  end

  def index
    @comments = Comment.all
    puts @comments
  end

end
