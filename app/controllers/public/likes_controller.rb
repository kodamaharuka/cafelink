class Public::LikesController < ApplicationController
    before_action :authenticate_user!

  def create
    like = Like.create(user_id: current_user.id, post_id: @post.id)
    #like = current_user.likes.build(post_id: @post.id)
    @like = current_user.likes.create(post_id: params[:post_id])
    like.save
    # redirect_back(fallback_location: root_path)
  end

  def destroy
    like = Like.create(user_id: current_user.id, post_id: @post.id)
    #like = current_user.likes.find_by(post_id: @post.id)
    like.destroy
    # redirect_back(fallback_location: root_path)
  end
  
  private
  
  def set_post
    # @post = Post.find_by(id: params[:post_id])
    @post = Post.find(params[:post_id])
  end
end
