class PlaylistsController < ApplicationController
  before_action :authorized
  before_action :find_playlist, only: [:show, :edit, :update, :destroy]

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

  def edit
  end

  def update
    @playlist.update(playlist_params)
    redirect_to playlist_path(@playlist)
  end

  def destroy
    PlaylistSong.destroy_by(playlist_id: @playlist.id)
    @playlist.destroy

    redirect_to user_path(current_user)
  end

  private

  def find_playlist
    @playlist = Playlist.find(params[:id])
  end

  def playlist_params
    params.require(:playlist).permit(:name)
  end

end
