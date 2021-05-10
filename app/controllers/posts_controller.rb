class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @post = Post.find(params[:id])
    @post_new = Post.new
    @comment = Comment.new
  end

  def index
    #@posts = Post.all
    @posts = Post.page(params[:page]).reverse_order
    @post = Post.new
  end

  # 投稿データの保存
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post), notice: "You have created post successfully."
    else
      @posts = Post.all
      render 'index'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "You have updated post successfully."
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "successfully delete post!"
  end

  # 投稿データのストロングパラメータ
  private

  def post_params
    params.require(:post).permit(:cafe_name, :image_id, :introduction)
  end

  def ensure_correct_user
      @post = Post.find(params[:id])
      unless @post.user == current_user
        redirect_to posts_path
      end
  end
end
