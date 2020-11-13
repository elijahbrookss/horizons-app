class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid? && @user.passwords_match(params[:password], params[:password_confirmation])
      @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:error] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def show
    @user1 = User.find(params[:id])
    @playlists = @user1.playlists
    @is_current_user = current_user?(@user1)
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end

  def current_user?(user)
    bool = user == current_user
    @user = user
    bool
  end

end
