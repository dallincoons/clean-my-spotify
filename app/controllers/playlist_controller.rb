require 'json'

class PlaylistController < ApplicationController
	def index
	    spotify = SpotifyGateway.new(session[:spotify_auth])

	    @playlists = spotify.get_playlists
	end

	def show
		 @playlistid = params[:id]

		 spotify = SpotifyGateway.new(session[:spotify_auth])

		 playlist = spotify.get_playlist_tracks(@playlistid)

		 tracks = TrackCollection.new(playlist).hydrate

		 @playlist = playlist
		 @duplicate_tracks =  tracks.duplicates.map do |song_id|
		 		Track.new(song_id, $redis.hget(song_id, 'name'))
		 end
	end

	def clean
		spotify = SpotifyGateway.new(session[:spotify_auth])

		spotify.remove_duplicate_tracks(params[:id], (JSON.parse params[:duplicate_tracks]))

		redirect_to :controller => 'playlist', :action => 'show', :id => params[:id]
	end
end
