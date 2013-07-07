class PlazaController < ApplicationController

  def hotposts
    @ranked_microposts = Micropost.rank
  end
end