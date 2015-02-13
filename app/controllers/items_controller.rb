class ItemsController < ApplicationController


  def index
    @freepiles = Item.all
    if params.has_key?(:topic)
      tags = params[:topic].split(',')
      @freepiles = @freepiles.tagged_with([tags],:on => :topic, :any => true)
    end
  end


end
