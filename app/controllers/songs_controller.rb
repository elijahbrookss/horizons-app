class SongsController < ApplicationController
  before_action :authorized, only: [:index]

  def index
    @songs = Api.search(params[:search])
    @playlists = current_user.playlists
  end

  def add_playlist
    @playlist = Playlist.find(params[:playlist_id])
    @song = Song.create_song(params[:song])

    @playlist.songs << @song
  end


  def destroy
    @song = Song.find(params[:id])
    @playlist = Playlist.find(params[:playlist_id])
    PlaylistSong.destroy_by(song_id: @song.id)

    redirect_to playlist_path(@playlist)
  end


end
