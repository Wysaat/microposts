module SessionsHelper
	
	def sign_in(user)
		self.current_user = user
	end

	def sign_in?(user)
		!current_user.nil?
	end

	def current_user
		@current_user
	end

	def current_user?(user)
		user == current_user
	end

  def current_user=(user)
  	@current_user = user
  end

  def redirect_back_or(default)
  end

end
