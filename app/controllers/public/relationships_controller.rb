class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  
  def followings
		@user = User.find(params[:id])
		@users = @user.followings.all
  end

  def followers
		@user = User.find(params[:id])
		@users = @user.followers.all
  end
  
	def create
		following = current_user.follow(@user)
    if following.save
      flash[:notice] = 'フォローしました'
      # redirect_back(fallback_location: root_path)
      redirect_back(fallback_location: root_path)
    else
      flash.now[:notice] = 'フォローに失敗しました'
      # redirect_back(fallback_location: root_path)
    end
  end

	def destroy
		following = current_user.unfollow(@user)
    if following.destroy
      flash[:notice] = 'フォローを解除しました'
      # redirect_back(fallback_location: root_path)
      redirect_back(fallback_location: root_path)
    else
      flash.now[:notice] = 'フォロー解除に失敗しました'
      # redirect_back(fallback_location: root_path)
    end
  end
  
  private

  def set_user
    @user = User.find_by(id: params[:follower_id])
  end
end