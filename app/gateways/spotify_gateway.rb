require 'net/http'
require 'rspotify'

class SpotifyGateway
	def initialize(auth)
		@spotify_user = RSpotify::User.new(auth)
	end	

	def get_playlists
		@spotify_user.playlists(limit: 50)
	end

	def get_playlist_tracks(id)
		userid = @spotify_user.id
		playlist = RSpotify::Playlist.find(userid, id)

		tracks = playlist.tracks.map do |track|
			Track.new('id', track.name)
		end

		tracks
	end

	def remove_duplicate_tracks(playlistid, ids)
		playlist = RSpotify::Playlist.find(@spotify_user.id, playlistid)
		tracks = RSpotify::Track.find(ids)
		playlist.remove_tracks!(tracks)
		playlist.add_tracks!(tracks)
	end
end