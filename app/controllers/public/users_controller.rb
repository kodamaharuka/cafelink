class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  #def index
     #@users = User.all
     #@post = Post.new
  #end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @post = Post.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: '更新しました'
    else
      render :edit
    end
  end

  def unsubscribe
    @user = User.find(params[:id])
  end

  def withdraw
    @user = User.find(params[:id])
    # is_deletedカラムにフラグを立てる(defaultはfalse)
    if @user.update(is_deleted: true)
      # ログアウトさせる
      reset_session
      redirect_to root_path, notice: 'ありがとうございました。またのご利用をお待ちしております。'
    end
  end


  private

  def forbid_test_user
    if @user.email == 'test@example.com'
      flash[:notice] = 'テストユーザーのため変更できません'
      redirect_to root_path
    end
  end

  def ensure_correct_user
    @user = User.find_by(id: params[:id])
    redirect_to user_path(current_user.id) if @user.id != current_user.id
  end

  def user_params
    params.require(:user).permit(:name, :email, :profile_image, :introduction, :is_deleted)
  end
end