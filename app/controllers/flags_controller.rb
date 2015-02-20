class FlagsController < ApplicationController
  respond_to :js

  def create
    @flag = Flag.create(flag_params)
    @flag.save
  end

  private

  def flag_params
    params.permit(:flagged_by, :item_id, :user_id, :term, :term_type, :comment)
  end

end
