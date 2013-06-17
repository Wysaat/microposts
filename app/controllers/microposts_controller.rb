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

end
