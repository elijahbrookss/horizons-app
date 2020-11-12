Rails.application.routes.draw do

  resources :songs, only: [:index]
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:create]
  resources :playlists

  get '/', to: "application#search"
  get '/login', to: "sessions#new"
end
