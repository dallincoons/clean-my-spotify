# Be sure to restart your server when you modify this file.

Figaro.load

RSpotify.authenticate(ENV['spotify_client_id'], ENV['spotify_client_secret'])

require "#{Rails.root}/app/gateways/spotify_gateway.rb"
