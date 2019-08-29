require 'net/http'
require 'rspotify'

class SpotifyGateway
	def initialize(auth)
		@spotify_user = RSpotify::User.new(auth)
	end

	def get_playlists
		@spotify_user.playlists(limit: 50)
	end

	def get_playlist(playlistid)
		RSpotify::Playlist.find(@spotify_user.id, playlistid)
	end

	def remove_duplicate_tracks(playlistid, ids)
		playlist = RSpotify::Playlist.find(@spotify_user.id, playlistid)
		ids.in_groups_of(50, false) { |ids_slice|
			tracks = RSpotify::Track.find(Array.wrap(ids_slice))
			playlist.remove_tracks!(tracks)
			playlist.add_tracks!(tracks)
		}
	end
end
