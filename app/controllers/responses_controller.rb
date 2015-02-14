class ResponsesController < ApplicationController

  respond_to :js

  def create
    @item = Question.find(params[:question_id])
    @response = Response.new(:question_id => params[:question_id], :user => current_user, :answer_id => params[:answer_id])
    @item.responses << @response

  end

end
