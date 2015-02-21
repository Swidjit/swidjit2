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

  def payment
    @claim = Claim.find(params[:claim_id])
    @cost = Item.find(@claim.item_id).prices.where(:currency=>params[:currency]).first
    @payer_balance = current_user.balances.where(:currency=>params[:currency]).first
    if @cost.value <= @payer_balance.value

      @xfer = Transfer.new
      @xfer.recipient_id = @claim.item.user.id
      @xfer.sender_id = current_user.id
      @xfer.transfer_status = "pending"
      @xfer.category = "sale"
      @xfer.item_id = @claim.item.id
      @xfer.value = @cost.value
      @xfer.currency = @cost.currency
      @xfer.save
      puts "you have enough"
    else
      puts "not enough"
    end
  end

  def claim_params
    params.require(:claim).permit([:item_id])
  end

end
