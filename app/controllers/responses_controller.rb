class ResponsesController < ApplicationController

  respond_to :js

  def create

    @item = Question.find(params[:question_id])
    @answer_id = params[:answer_id].to_i
    current_user.responses.where(:question_id => params[:question_id]).destroy_all
    @response = Response.new(:question_id => params[:question_id], :user => current_user, :answer_id => params[:answer_id])
    @item.responses << @response
  end

end
