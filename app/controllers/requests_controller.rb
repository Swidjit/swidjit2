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
    Item.where(:request_id => params[:id]).update_all(request_id: 0)
    @request = Request.find(params[:id])
    @request.destroy
    respond_to do |format|
      format.js
    end
  end

  def request_params
    params.require(:request).permit([:title, :item_type, :body])
  end

end
