class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      sessions[:user_id] = @user.id
      redirect_to '/'
    else
      flash[:errors] = ["Invalid password or username"]
      redirect_to login_path
    end
  end
end
