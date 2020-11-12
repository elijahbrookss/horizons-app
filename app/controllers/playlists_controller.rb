class PlaylistsController < ApplicationController
  before_action :authorized, only: [:create]

  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = Playlist.new(playlist_params)
    if @playlist.valid?
      @playlist.user_id = current_user.id
      @playlist.save
      redirect_to user_path(current_user)
    else
      redirect_to new_playlist_path
    end
  end

  def show
  end

  private

  def playlist_params
    params.require(:playlist).permit(:name)
  end

end
