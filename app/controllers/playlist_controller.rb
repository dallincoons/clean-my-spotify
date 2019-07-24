require 'json'

class PlaylistController < ApplicationController
	def index
	    spotify = SpotifyGateway.new(session[:spotify_auth])

	    @playlists = spotify.get_playlists
	end

	def show
		 @playlistid = params[:id]

		 playlist = RSpotify::Playlist.find(RSpotify::User.new(session[:spotify_auth]).id, @playlistid)

		 tracks = TrackCollection.new(playlist.id)

		 if playlist.total != tracks.count + 1
		 		tracks.clear_cache
			  tracks.get_playlist_tracks(playlist)
     end

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
