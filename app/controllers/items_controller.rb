class ItemsController < ApplicationController


  def index
    @items = Item.all
    if params.has_key?(:cat)
      @events = Item.joins(:occurrences).where("items.type = ?",params[:cat].camelcase)
    else
      @events = Item.joins(:occurrences).order('occurrences.dt ASC')
    end
    if params.has_key?(:topic)
      tags = params[:topic].split(',')
      @items = @items.tagged_with([tags],:on => :topic, :any => true)
    end

  end

  def show
    @item = Item.find(params[:id])
  end

  def autocomplete_topic_search
    @tags = Item.topic_counts.where("name LIKE (?)","%#{params[:q]}%")
    respond_to do |format|
      format.json { render :json => @tags.collect{|tag| {:id => tag.name, :name => tag.name}} }
    end
  end

  def upload_file
    @item = Item.unscoped.find(params[:id])
    @item.images << Image.create(:pic => URI.parse(URI.unescape(params['url'])))

  end

  def update
    @item = Item.find(params[:id])
    if(params[:item][:source]=="scheduler")
      @item.recurrences.delete_all
      @item.occurrences.delete_all
    end
    @item.update_attributes(item_params)

  end

  def filter
    case params[:type]
      when 'all'
        @items = Item.all
      when 'popular'
        @items = Item.popular
      when 'upcoming'
        @items = Item.happening_soon
      when 'nearby'
        @items = Item.nearby
      when 'followed'
        @items = Item.by_users(current_user.subscriptions.collect(&:subscription_id))
    end
  end

  def create_or_destroy_reaction
    @item = Item.find(params[:id])
    cancelled = false;
    @reaction = Reaction.where(:item_id => params[:id], :user_id => current_user.id, :reaction_type => params[:type]).first
    if @reaction.present?
      Reaction.destroy(@reaction.id)
      cancelled = true
    else
      @reaction = Reaction.create(:item_id => params[:id], :user_id => current_user.id, :reaction_type => params[:type])
    end
    case params[:type]
      when 'like'
        if cancelled
          @item.update_attribute(:importance, @item.importance+1)
        else
          @item.update_attribute(:importance, @item.importance+1)
        end

        @count = @item.reactions.liked.size
        @class = "like"
        render 'reactions/liked'
      when 'love'
        if cancelled
          @item.update_attribute(:importance, @item.importance-3)
        else
          @item.update_attribute(:importance, @item.importance+3)
        end


        @count = @item.reactions.loved.size
        @class = "love"
        render 'reactions/liked'
      when 'share'
        if cancelled
          @item.update_attribute(:importance, @item.importance-5)
        else
          @item.update_attribute(:importance, @item.importance+5)
        end
        @count = @item.reactions.shared.size
        @class = "share"
        render 'reactions/liked'
      when 'off-topic'
        @count = @item.reactions.offensive.size + @item.reactions.off_topic.size
        if @count >= 3
          @item.update_attribute(:status, 'flagged')
        end
        @class = "flag"
        render 'reactions/flagged'
      when 'offensive'
        @count = @item.reactions.offensive.size + @item.reactions.off_topic.size
        if @count >= 3
          @item.update_attribute(:status, 'flagged')
        end
        @class = "flag"
        render 'reactions/flagged'
    end
  end

  def item_params
    params.require(:item).permit(recurrences_attributes: [:start_datetime, :end_datetime, :recur_until, :recur_day, :recur_week, :recurrence_type])
  end
end
