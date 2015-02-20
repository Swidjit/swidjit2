class OffersController < ApplicationController
  respond_to :js

  def create
    @item = Item.unscoped.find(params[:product_id])
    @offer = Offer.create(offer_params)
    current_user.offers << @offer

  end

  def destroy
     @offer = Offer.find(params[:id])
     @offer.destroy
  end

  def offer_params
    params.require(:offer).permit([:value, :currency, :item_id])
  end

end
