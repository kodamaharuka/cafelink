class Public::CommentsController < ApplicationController
    before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = @post.id
    comment.save
    # redirect_back(fallback_location: root_path)
    # render :index
    @comment = Comment.new
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:post_id])
    Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    # redirect_back(fallback_location: root_path)
    # render :index
    @comment = Comment.new
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :comment)
  end
end