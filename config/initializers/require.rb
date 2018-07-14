# Be sure to restart your server when you modify this file.

Figaro.load

RSpotify.authenticate(ENV['spotify_client_id'], "3e37707325b44247895d80abc9c4e89a")

require "#{Rails.root}/app/gateways/spotify_gateway.rb"
