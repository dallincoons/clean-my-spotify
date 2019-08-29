Rails.application.routes.draw do
  get 'spotify/connect'
  get '/auth/spotify/callback', to: 'users#spotify'
  get '/playlists', to: 'playlist#index'
  get '/playlist/:id', to: 'playlist#show'
  get '/playlist/:id/duplicates', to: 'duplicate_tracks#show'
  post '/playlist/:id/duplicates', to: 'duplicate_tracks#delete'
  root 'welcome#index'
end
