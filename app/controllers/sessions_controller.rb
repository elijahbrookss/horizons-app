class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:errors] = ["Invalid password or username"]
      redirect_to login_path
    end
  end

  def logout
    session.destroy
    redirect_to login_path
  end



end
