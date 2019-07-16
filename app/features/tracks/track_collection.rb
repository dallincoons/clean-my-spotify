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

  def get_playlist_tracks(playlist, offset = 1)
      raw_tracks = playlist.tracks(limit: 100, offset: offset)
      if raw_tracks.length > 0
        self.add_raw_tracks(raw_tracks)
        self.get_playlist_tracks(playlist, offset += 100)
      end
      @tracks
  end

  def all
    @tracks
  end
end
