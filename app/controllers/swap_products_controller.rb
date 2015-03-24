class SwapProductsController < ApplicationController
  respond_to :html
  def create
    @item = SwapProduct.create(item_params)
    current_user.items << @item
    @item.topic_list = item_params[:topic_list]
    @item.save

  end

  def new
    @product = SwapProduct.new
  end
  def show
    @item = SwapProduct.find(params[:id])
    render :template => 'items/show'
  end

  def update
    @item = SwapProduct.find(params[:id])
    @item.update_attributes(item_params)
    respond_with @item, :template => 'items/show'
  end

  def item_params
    params.require(:swap_product).permit(:title, :details, :condition, :topic_list, prices_attributes:[:negotiable, :value, :currency, :digital_payment])
  end

  def index
    @products = SwapProduct.all
  end

end
