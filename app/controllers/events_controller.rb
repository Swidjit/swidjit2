class EventsController < ApplicationController

  def create
    item = Event.new(item_params)
    current_user.items << item
    item.topic_list = item_params[:topic_list]
    item.save


  end

  def new
    @item = Event.new
  end

  def item_params
    params.require(:event).permit(:title, :details, :address, :latlng, :topic_list, :spots_attributes => [:spot_type, :spot_count])
  end

  def index
    @items = Item.joins(:occurrences).where("items.type = 'Event'").order('occurrences.dt ASC')
    #@tom = Item.joins(:occurrences).where("items.type = 'Event' and occurrences.dt::date = ?",Date.tomorrow).order('occurrences.dt ASC')
  end

  def day

    @items = Item.joins(:occurrences).where("items.type = 'Event' and occurrences.dt::date = ?",params[:date]).order('occurrences.dt ASC')

  end

  def show
    @item = Event.find(params[:id])
    5.times {@item.recurrences.build}
    @comments = @item.comment_threads.order('created_at desc')
    @new_comment = Comment.build_from(@item, current_user.id, "") if user_signed_in?
    @dates = Occurrence.joins(:items).where('#{Occurrence.table_name}.item_id = #{Item.table_name}.id').order(dt: :asc)

  end

end
