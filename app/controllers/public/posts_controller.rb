class Public::PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @genres = Genre.all
    @post = Post.new
    #@shop = Shop.find_by(isbn: params[:shop_id])
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, notice: "つぶやきを投稿しました"
      #redirect_to user_path(current_user), notice: "つぶやきを投稿しました"
    else
      flash.now[:alert] = "つぶやき投稿失敗しました"
      render :new
    end
  end

  def index
    @genres = Genre.all
    #@posts = @shop.post
    @posts = Post.all.page(params[:page]).per(12).order(created_at: "DESC")
    #@posts = @shop.posts
  end
  
  def edit
    @genres = Genre.all
    @post = Post.find(params[:id])
  end

  def show
    @genres = Genre.all
    @post = Post.find(params[:id])
    #@shop = Shop.find_by(isbn: params[:shop_id])
    @comment = Comment.new
    @user = @post.user
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
    @post = Post.find(params[:id])
    @post.user_id = current_user.id
    @post.destroy
    redirect_to posts_path
  end

  # 投稿データのストロングパラメータ
  private

  def post_params
    params.require(:post).permit(:cafe_name, :image, :introduction)
  end

  def ensure_correct_user
      @post = Post.find(params[:id])
      unless @post.user == current_user
        redirect_to posts_path
      end
  end
end
