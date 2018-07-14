class SpotifyGatewayTest < ActionDispatch::IntegrationTest
	test "it finds duplicate tracks" do
		duplicateFinder = DuplicateTracks.new([
			Track.new(1, 'Ziggy Stardust'), 
			Track.new(1, 'Ziggy Stardust'), 
			Track.new(2, 'Little Acorns')])

		duplicate_tracks = duplicateFinder.find
		
		assert_equal(1, duplicate_tracks.length);
		assert_equal(1, duplicate_tracks.first.id)
	end
end
