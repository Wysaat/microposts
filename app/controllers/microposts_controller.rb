class MicropostsController < ApplicationController

	def create
		@micropost = current_user.microposts.build(params[:micropost])
		if @micropost.save
			redirect_to root_path
		end
	end

	def destroy
		@micropost = current_user.microposts.find_by_id(params[:id])
		@micropost.destroy
		redirect_to root_path
	end

  def update
    @micropost = Micropost.find(params[:id])
    @user = @micropost.whose?

    if params[:buttondown] == "upvote" && 
       (not ( current_user.has_upvoted?(@micropost) ||
             current_user.has_downvoted?(@micropost) ))
      current_user.upvote!(@micropost)

    elsif params[:buttondown] == "downvote" &&
          (not ( current_user.has_upvoted?(@micropost) ||
                current_user.has_downvoted?(@micropost) ))
      current_user.downvote!(@micropost)

    elsif params[:buttondown] == "inappropriate" &&
          (not current_user.has_voted_inappropriate?(@micropost))
      current_user.inappropriate!(@micropost)

    else
      redirect_to @user
    end
  end

end
