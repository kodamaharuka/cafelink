class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @genres = Genre.all
    @post = Post.new
    @shop = Shop.find_by(isbn: params[:shop_id])
  end

  def create
    @poat = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to shop_path(@post.shop.isbn), notice: 'レビューを追加しました'
    else
      @shop = Shop.find_by(isbn: params[:shop_id])
      render :new
    end
  end

  def index
    @genres = Genre.all
    @posts = @shop.post
  end

  def show
    @genres = Genre.all
    @post = Post.find(params[:id])
    @shop = Shop.find_by(isbn: params[:shop_id])
    @comment = Comment.new
  end

  def edit
    @genres = Genre.all
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to shop_post_path(@post.id), notice: '更新しました'
    else
      @genres = Genre.all
      render :edit
    end
  end

  def destroy
    @genres = Genre.all
    @post = Post.find(params[:id])
    @post = Post.find_by(isbn: params[:post_id])
    @post.destroy
    redirect_to post_path(@post.isbn), notice: 'レビューを削除しました'
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
