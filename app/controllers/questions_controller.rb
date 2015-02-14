class QuestionsController < ApplicationController

  respond_to :js

  def create
    @item = Question.create(item_params)
    current_user.items << @item
    @item.topic_list = item_params[:topic_list]
    @item.save
    10.times {@item.answers.build}

  end

  def update
    @item = Question.find(params[:id])
    @item.update_attributes(item_params)
  end

  def new
    @question = Question.new

  end

  def show
    @item = Question.find(params[:id])
    @comments = @item.comment_threads.order('created_at desc')
    @new_comment = Comment.build_from(@item, current_user.id, "") if user_signed_in?
  end

  def item_params
    params.require(:question).permit(:details, :title, :condition, :topic_list, answers_attributes: [:answer])
  end

  def index
    @questions = Question.all
  end

end
