class AddColumnsToSongs < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :preview, :string
    add_column :songs, :album_picture, :string
    add_column :songs, :artist_picture, :string
    add_column :songs, :album, :string
  end
end
