class FreepilesController < ApplicationController

  def create
    Freepile.create(item_params)

  end

  def new
    @freepile = Freepile.new
  end

  def item_params
    params.require(:freepile).permit(:title, :details, :condition, :address, :latlng)
  end

  def index
    @freepiles = Freepile.all
    puts @freepiles
  end

  def show
    @freepile = Freepile.find(params[:id])
  end

end
