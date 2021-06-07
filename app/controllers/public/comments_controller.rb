class Public::CommentsController < ApplicationController
    before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.user_id = current_user.id
    comment.post_id = post.id
    comment.save
    redirect_to posts_path
  end

  def destroy
    Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    redirect_to posts_path
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :comment)
  end
end