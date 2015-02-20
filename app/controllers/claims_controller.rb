class ClaimsController < ApplicationController
  respond_to :js

  def create
    @item = Item.unscoped.find(params[:claim][:item_id])
    @claim = Claim.create(claim_params)
    current_user.claims << @claim

  end

  def destroy
     @claim = Claim.find(params[:id])
     @item = @claim.item
     @claim.destroy
  end

  def claim_params
    params.require(:claim).permit([:item_id])
  end

end
