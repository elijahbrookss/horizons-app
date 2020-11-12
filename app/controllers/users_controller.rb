class UsersController < ApplicationController
    
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid? && @user.passwords_match(params[:password], params[:password_confirmation])
      @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else
      flash[:error] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def show
    @user = User.find(params[:id])
    @playlists = @user.playlists
    @is_current_user = current_user?(@user)
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end

  def current_user?(user)
    user == current_user
  end

end
