class ClaimsController < ApplicationController
  respond_to :js

  def create
    @item = Item.unscoped.find(params[:claim][:item_id])
    @claim = Claim.new(claim_params)
    current_user.claims << @claim

  end

  def accept
    @claim = Claim.find(params[:claim_id])
    if params[:claim_condition] == "payment"
      @claim.update_attribute(:claim_status,"pending_payment")
    else
      @claim.update_attribute(:claim_status,"accepted")
    end
    #send message to user that claim has not been accepted
  end

  def destroy
     @claim = Claim.find(params[:id])
     @item = @claim.item
     @claim.destroy
  end

  def deny
     @claim = Claim.find(params[:claim_id])
     #send message to user that claim has not been accepted
     @item = @claim.item
     @claim.destroy
  end

  def claim_params
    params.require(:claim).permit([:item_id])
  end

end
