require 'json'

class PlaylistController < ApplicationController

	def index
	    spotify = SpotifyGateway.new(session[:spotify_auth])

	    @playlists = spotify.get_playlists
	end

	def show
		 @playlistid = params[:id]

		 spotify = SpotifyGateway.new(session[:spotify_auth])

		 playlist = spotify.get_playlist(@playlistid)

		 @playlist = playlist
	end
end
