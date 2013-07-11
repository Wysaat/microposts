class PlazaController < ApplicationController

  def hotposts
    @ranked_microposts = Micropost.rank
  end

  def home
    @users = User.all
    @ranked_users = User.rank
  end

end