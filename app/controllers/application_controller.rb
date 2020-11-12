class ApplicationController < ActionController::Base
    before_action :authorized, only: [:search]

    def search
      render "applications/search.html.erb"
    end

    def current_user
      if session[:user_id]
        @user = User.find(session[:user_id])
      end
    end

    def logged_in?
      !!current_user
    end

    def authorized
      redirect_to login_path unless logged_in?
    end
end
