class User < ApplicationRecord
  has_secure_password

  has_many :playlists
  has_many :songs, through: :playlists
  has_many :artists, through: :songs

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true

  def passwords_match(password, password_confirmation)
    if password == password_confirmation then
      return true
    end
    return nil
  end
end
