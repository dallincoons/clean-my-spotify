class TrackCollectionTest < ActionDispatch::IntegrationTest
  test "it builds track collection" do
      track_collection = TrackCollection.new

      track_collection.get_playlist_tracks(PlaylistMock.new)

      assert_equal(2, track_collection.all.length)
  end
end

class PlaylistMock
  @@track_offset = 1
  @@raw_tracks
  def initialize
    @@raw_tracks = RawTracksMock.new
  end
  def tracks(limit:, offset:)
      if @@track_offset > 2
        num_to_generate = 0
      else
        num_to_generate = 1
      end

      @@track_offset += 1

      @@raw_tracks.tracks(num_to_generate)
  end
end

class RawTracksMock
  def tracks(num_to_generate)
      tracks = []
      (1..num_to_generate).each do |n|
        tracks.push(TrackMock.new(rand(10).to_s(10), rand(10).to_s(10)))
      end
      tracks
  end
end

class TrackMock
  def initialize(id, name)
      @id = id
      @name = name
  end

  def id
    @id
  end

  def name
    @name
  end
end
