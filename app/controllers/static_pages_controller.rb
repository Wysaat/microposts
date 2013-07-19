class StaticPagesController < ApplicationController

	def home
		if signed_in?
		  @micropost = current_user.microposts.build
		  @user = current_user
		  @microposts = @user.microposts
		else
			@pcomment = Pcomment.all[0]
		end
	end

	def help
	end

	def about
	end

	def contact
	end

	def news
	end

end
