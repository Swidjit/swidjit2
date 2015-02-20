class ProductsController < ApplicationController
  respond_to :html
  def create
    @item = Product.create(item_params)
    current_user.items << @item
    @item.topic_list = item_params[:topic_list]
    @item.save

  end

  def new
    @product = Product.new
  end
  def show
    @item = Product.find(params[:id])
    render :template => 'items/show'
  end

  def update
    @item = Product.find(params[:id])
    @item.update_attributes(item_params)
    respond_with @item, :template => 'items/show'
  end

  def item_params
    params.require(:product).permit(:title, :details, :condition, :topic_list, prices_attributes:[:negotiable, :value, :currency, :digital_payment])
  end

  def index
    @products = Product.all
  end

end
