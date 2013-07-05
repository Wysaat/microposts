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

    if params[:buttondown] == "upvote"
      @micropost.update_attribute(:upvotes, @micropost.upvotes + 1)
    elsif params[:buttondown] == "downvote"
      @micropost.update_attribute(:downvotes, @micropost.downvotes + 1)
    else
      @micropost.update_attribute(:inappropriate, @micropost.inappropriate + 1)
    end
  end

end
