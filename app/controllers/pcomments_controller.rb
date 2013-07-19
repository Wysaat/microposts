class PcommentsController < ApplicationController
  def update
    @pcomment = Pcomment.all[0]
    if params[:pcomment][:good] == params[:pcomment][:bad]
      return
    ###################################################################
    ######### the following should be "1" rather than 1 ###############
    ###################################################################
    elsif params[:pcomment][:good] == "1"
      @pcomment.update_attribute(:good, @pcomment.good + 1)
    else
      @pcomment.update_attribute(:bad, @pcomment.bad + 1)
    end
  end
end
