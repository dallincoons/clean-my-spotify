require 'json'

class PlaylistController < ApplicationController
	def index
	    spotify = SpotifyGateway.new(session[:spotify_auth])

	    @playlists = spotify.get_playlists
	end

	def show
		 @playlistid = params[:id]

		 playlist = RSpotify::Playlist.find(RSpotify::User.new(session[:spotify_auth]).id, @playlistid)

		 tracks = TrackCollection.new

		 tracks.get_playlist_tracks(playlist)

		 duplicate_tracks = DuplicateTracks.new(tracks.all)

		 @playlist = playlist
		 @duplicate_tracks = duplicate_tracks.find
	end

	def clean
		spotify = SpotifyGateway.new(session[:spotify_auth])

		spotify.remove_duplicate_tracks(params[:id], (JSON.parse params[:duplicate_tracks]))

		redirect_to :controller => 'playlist', :action => 'show', :id => params[:id]
	end
end
