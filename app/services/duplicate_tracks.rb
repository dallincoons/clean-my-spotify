class DuplicateTracks
	def initialize(tracks)
		@tracks = tracks
	end

	def find
		parking_lot = []
		duplicates = []
		@tracks.each do |track|
			if not parking_lot.include? track.id
				parking_lot << track.id
			else
				duplicates << track
			end
		end
		duplicates
	end
end
