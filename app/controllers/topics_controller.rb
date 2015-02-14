class TopicsController < ApplicationController

  def create
    item = Topic.create(item_params)
    current_user.items << item
    item.topic_list = item_params[:topic_list]
    item.save

  end

  def new
    @topic = Topic.new
  end

  def item_params
    params.require(:topic).permit(:details, :topic_list)
  end

  def index
    @topics = Topic.all
    puts @topics
  end

end
