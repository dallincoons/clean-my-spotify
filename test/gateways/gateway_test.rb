class TrackCollectionTest < ActionDispatch::IntegrationTest
  test "it adds song to cache" do
    cache = PlaylistCache.new('1234')

    cache.add(Song.new)
  end
end
