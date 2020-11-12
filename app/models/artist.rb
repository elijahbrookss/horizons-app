class Artist < ApplicationRecord
  has_many :songs
  has_many :users, through: :songs
end
