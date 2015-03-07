class TransfersController < ApplicationController

  respond_to :html, :json

  def pay
    @amount = params[:amount].to_i*100

    puts params
    puts @amount


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




  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end

end
