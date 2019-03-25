require 'json'

class PlaylistController < ApplicationController
	def index
	    spotify = SpotifyGateway.new(session[:spotify_auth])

	    @playlists = spotify.get_playlists
	end

	def show
		 @playlistid = params[:id]

			playlist = RSpotify::Playlist.find(RSpotify::User.new(session[:spotify_auth]).id, @playlistid)

			offset = 0
			raw_tracks = playlist.tracks(limit: 100, offset: offset)
			tracks = []
			while raw_tracks.length > 0
				new_tracks = raw_tracks.map do |track|
					Track.new(track.id, track.name)
				end
				tracks.concat(new_tracks)
				offset += 100
				raw_tracks = playlist.tracks(limit: 100, offset: offset)
			end

			duplicate_tracks = DuplicateTracks.new(tracks)

		 @playlist = playlist
		 @duplicate_tracks = duplicate_tracks.find
	end

	def clean
		spotify = SpotifyGateway.new(session[:spotify_auth])

		spotify.remove_duplicate_tracks(params[:id], (JSON.parse params[:duplicate_tracks]))

		redirect_to :controller => 'playlist', :action => 'show', :id => params[:id]
	end
end
