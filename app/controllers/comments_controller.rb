class CommentsController < ApplicationController
  def create
    @comment = Comment.new
    @comment.content = params[:comment][:content]
    @comment.topic_id = params[:topic][:id]
    @comment.owner_id = current_user.id

    @topic = Topic.find(@comment.topic_id)

    if @comment.save
      @topic.update_comments_num
      current_user.update_comments_num
      redirect_to @topic
    end

  end

end
