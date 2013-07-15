class ForumsController < ApplicationController
  def create
    if signed_in? && current_user.admin
      @forum = Forum.new
      @forum.name = params[:forum][:name]    
      if @forum.save
        redirect_to forums_path
      end
    else
      redirect_to forums_path
    end
  end

  def show
    @forum = Forum.find(params[:id])
    @new_topic = Topic.new
    @topics = @forum.topics.all
  end

  def index
    @forums = Forum.all
  end

  def new
    if signed_in? && current_user.admin
      @forum = Forum.new
    else
      redirect_to forums_path
    end
  end
end
