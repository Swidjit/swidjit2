class WebsitesController < ApplicationController
  def create
    item = Website.create(item_params)
    current_user.items << item
    item.topic_list = item_params[:topic_list]
    item.save

  end

  def new
    @website = Website.new
  end

  def item_params
    params.require(:website).permit(:details, :topic_list, urls_attributes: [:url, :title, :description, :image_url] )
  end

  def index
    @websites = Website.all
    puts @websites
  end


  def scrape
    if params[:url]
      @page = MetaInspector.new(params[:url],
                                :warn_level => :store,
                                :connection_timeout => 5, :read_timeout => 5,
                                :headers => { 'User-Agent' => user_agent, 'Accept-Encoding' => 'identity' })
      if @page.response.nil?
        render 'scrape_failed'
      else
      end
    end
  end

  private

  def user_agent
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.111 Safari/537.36"
  end
end
