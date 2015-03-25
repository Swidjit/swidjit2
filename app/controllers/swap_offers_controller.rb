class SwapOffersController < ApplicationController
  respond_to :js

  def create
    SwapOffer.create(:productsA => '{'+params[:swap_offer][:productsA]+'}',:productsB => '{'+params[:swap_offer][:productsB]+'}', :userA_id => params[:swap_offer][:userA_id], :userB_id => params[:swap_offer][:userB_id])
  end

  def destroy
     @offer = SwapOffer.find(params[:id])
     @offer.destroy
  end

  def item_params
    params.require(:swap_offer).permit([:productsA, :productsB, :userA_id, :userB_id, :expiration])
  end

end
