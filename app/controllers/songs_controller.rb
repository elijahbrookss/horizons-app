class SongsController < ApplicationController
  before_action :authorized, only: [:index]

  def index
    @songs = Api.search(params[:search])
  end
  
end
