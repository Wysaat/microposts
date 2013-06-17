class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
		@micropost = current_user.microposts.build
		@microposts = @user.microposts
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			sign_in @user
			# flash[:success] = "Welcom to MicroPosts.com!"
			redirect_to @user
		else
			render 'new'
		end
	end

	def showall
		@users = User.all
	end

end
