class TrackCollection
  def initialize
    @tracks = []
  end

  def add_raw_tracks(raw_tracks)
    new_tracks = raw_tracks.map do |track|
      Track.new(track.id, track.name)
    end
    @tracks.concat(new_tracks)
  end

  def all
    @tracks
  end
end
