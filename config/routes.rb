Rails.application.routes.draw do

  resources :songs, only: [:index]
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:create]
  resources :playlists, except: [:destroy]

  post '/add_playlist', to: "songs#add_playlist"
  delete '/songs/:id', to: "songs#destroy", as: "destroy_song"
  delete '/playlists/:id', to: "playlists#destroy", as: "destroy_playlist"

  get '/logout', to: "sessions#logout"
  get '/', to: "application#search"
  get '/login', to: "sessions#new"
end
