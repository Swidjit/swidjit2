class InvoicesController < ApplicationController
  def pay
    if params.has_key?("id")
      invoice = Invoice.find(params[:id])
      invoice.update_attribute(:invoice_status,"paid")
      puts "heyssss"
    else
      invoices = current_user.invoices.where(:invoice_status => "unpaid")
    end
    @amount = params[:amount].to_f*100

    puts params[:amount]
    puts @amount


    customer = Stripe::Customer.create(
      :email => current_user.email,
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount.to_i,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

    redirect_to :back


  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end

end
