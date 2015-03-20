class FreepilesController < ApplicationController

  def create
    item = Freepile.create(item_params)
    current_user.items << item
    item.topic_list = item_params[:topic_list]
    item.save


  end

  def new
    @freepile = Freepile.new
  end

  def item_params
    params.require(:freepile).permit(:title, :details, :condition, :address, :latlng, :topic_list, :request_id)
  end

  def index
    @freepiles = Freepile.all
    @requests = Request.where(:item_type => "freepile")
  end

  def show
    @freepile = Freepile.find(params[:id])
    @comments = @freepile.comment_threads.order('created_at desc')
    @new_comment = Comment.build_from(@freepile, current_user.id, "") if user_signed_in?
  end

end
