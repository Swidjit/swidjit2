class RequestsController < ApplicationController
  respond_to :js

  def create
    @request = Request.new(request_params)
    current_user.requests << @request
    respond_to do |format|
      format.js
    end
  end

  def destroy
     @request = Request.find(params[:id])
     @request.destroy
  end

  def request_params
    params.require(:request).permit([:title, :item_type, :body])
  end

end
