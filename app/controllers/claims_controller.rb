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
      @payer_balance.decrement!(:value,@cost.value)
      @payee_balance = @claim.item.user.balances.where(:currency=>params[:currency]).first
      @payee_balance.increment!(:value,@cost.value)
      @claim.update_attribute(:claim_status, "accepted")
      @claim.item.update_attribute(:publish_status,"purchased")
    else
      respond_to do |format|
        format.js {render 'deposit_form'}
      end
    end
  end

  def finish_payment

    @claim = Claim.find(params[:claim_id])
    @amount = params[:amount].to_i*100

    customer = Stripe::Customer.create(
      :email => current_user.email,
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
      )
    @payer_balance = current_user.balances.where(:currency=>'usd').first
    @payer_balance.increment!(:value,charge.amount/100)
    puts "heeyye"
    @cost = Item.find(@claim.item_id).prices.where(:currency=>'usd').first
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
      puts "SDfsdfs"
      @payer_balance.decrement!(:value,@cost.value)
      @payee_balance = @claim.item.user.balances.where(:currency=>'usd').first
      @payee_balance.increment!(:value,@cost.value)
      @claim.update_attribute(:claim_status, "accepted")
      @claim.item.update_attribute(:publish_status,"purchased")
    end
    redirect_to :back
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end

  def claim_params
    params.require(:claim).permit([:item_id])
  end

end
