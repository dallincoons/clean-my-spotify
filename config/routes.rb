Rails.application.routes.draw do
  get 'spotify/connect'
  get '/auth/spotify/callback', to: 'users#spotify'
  get '/playlists', to: 'playlist#index'
  get '/playlist/:id', to: 'playlist#show'
  post '/playlist/:id/clean', to: 'playlist#clean'
  root 'welcome#index'
end
