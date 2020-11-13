class Song < ApplicationRecord
  belongs_to :artist
  has_many :playlist_songs
  has_many :playlists, through: :playlist_songs


  def self.create_song(attributes)
    attributes = JSON.parse(attributes.gsub(/:([a-zA-z]+)/,'"\\1"').gsub('=>', ': ')).symbolize_keys
    @artist = Artist.create_or_find_by(name: attributes[:artist_name])
    attributes[:name] = attributes[:song_name]
    attributes[:artist_id] = @artist.id
    attributes.delete(:song_name)
    attributes.delete(:artist_name)
    Song.create_or_find_by(attributes)
  end
end
