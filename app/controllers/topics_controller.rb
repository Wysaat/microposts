class TopicsController < ApplicationController
  def create
    @topic = Topic.new
    @topic.title = params[:topic][:title]
    @topic.content = params[:topic][:content]
    @topic.owner_id = current_user.id
    @topic.forum_id = params[:forum][:id]

    @forum = Forum.find(@topic.forum_id)

    if @topic.save
      @forum.update_topics_num
      current_user.update_topics_num
      redirect_to @topic
    end
  end

  def show
    @topic = Topic.find(params[:id])
    @new_comment = Comment.new
    @comments = @topic.comments.all
  end

  def index
    @topics = Topic.all
  end
end
