class UsersController < ApplicationController
  before_action :corrent_user, only: [:edit]
  def show
  	  @user = User.find(params[:id])
  	  @post_images = @user.post_images.page(params[:page]).reverse_order

  end

  def index
      @users = User.page(params[:page]).search(params[:search])
      @user = current_user
      @post_images = @user.post_images
  end

  def edit
  	  @user = User.find(params[:id])
  end

  def update
  	  @user = User.find(params[:id])
  	  @user.update(user_params)
  	  redirect_to user_path(@user.id)
  end

  def following
      @user = User.find(params[:id])
      @users = @user.followings
      render 'show_follow'
  end

  def followers
      @user = User.find(params[:id])
      @users = @user.followers
      render 'show_follower'
  end

  private
  def correct_user
      @user = User.find(params[:id])
    if current_user != @user
       redirect_to users_path
    end
  end

  def user_params
  	  params.require(:user).permit(:name, :profile_image)
  end
end
