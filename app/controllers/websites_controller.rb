class WebsitesController < ApplicationController

  def scrape
    if params[:url]
      @page = MetaInspector.new(params[:url],
                                :warn_level => :store,
                                :connection_timeout => 5, :read_timeout => 5,
                                :headers => { 'User-Agent' => user_agent, 'Accept-Encoding' => 'identity' })
    else
      redirect "/"
    end
  end

  private

  def user_agent
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.111 Safari/537.36"
  end
end
