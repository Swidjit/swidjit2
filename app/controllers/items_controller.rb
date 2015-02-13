class ItemsController < ApplicationController


  def index
    @freepiles = Item.all
    if params.has_key?(:topic)
      tags = params[:topic].split(',')
      @freepiles = @freepiles.tagged_with([tags],:on => :topic, :any => true)
    end
  end

  def autocomplete_topic_search
    @tags = Item.topic_counts.where("name LIKE (?)","%#{params[:q]}%")
    respond_to do |format|
      format.json { render :json => @tags.collect{|tag| {:id => tag.name, :name => tag.name}} }
    end
  end


end
