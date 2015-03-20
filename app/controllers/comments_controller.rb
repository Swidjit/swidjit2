class CommentsController < ApplicationController
  respond_to :json, :html
  def create
    @comment_hash = params[:comment]
    @obj = @comment_hash[:commentable_type].constantize.find(@comment_hash[:commentable_id])
    # Not implemented: check to see whether the user has permission to create a comment on this object
    @comment = Comment.build_from(@obj, current_user.id, @comment_hash[:body])
    if @comment.save
      puts @obj.class
      if @obj.class == Request
        render :partial => "show_comment_on_request", :locals => { :comment => @comment, :obj => @obj }, :layout => false, :status => :created

      else
        render :partial => "show_comment", :locals => { :comment => @comment }, :layout => false, :status => :created
      end
    else
      render :js => "alert('error saving comment');"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy

    else
      render :js => "alert('error deleting comment');"
    end
  end

  def update
    @comment = Comment.find params[:id]

    respond_to do |format|
      if @comment.update_attributes(comment_params)
        format.html { redirect_to(@comment, :notice => 'User was successfully updated.') }
        format.json { respond_with_bip(@comment) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@comment) }
      end
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

end