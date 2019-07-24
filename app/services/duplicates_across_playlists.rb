class DuplicatesAcrossPlaylists
	@playlist_ids
	@duplicates = {}
	@songs = {}
	def initialize(playlists)
		@playlists = playlists
		@songs = {}
		@duplicates = {}
	end

	def get
		@playlists.each do |playlist|
				self.add_tracks(playlist)
		end

		@duplicates
	end

	def add_tracks(playlist)
		playlist.get.each do |song|
			if @songs.key?(song)
				@songs[song].push(playlist.playlist_id)
				@duplicates[song] = @songs[song]
			else
				@songs[song] = [playlist.playlist_id]
			end
		end

		if playlist.duplicates.length > 0
			playlist.duplicates.each do |duplicate|
				if @duplicates.key?(duplicate)
					@duplicates[duplicate].push(playlist.playlist_id)
				else
					@duplicates[duplicate] = [playlist.playlist_id]
				end
		end
		end
	end
end
