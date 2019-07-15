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

  def get_playlist_tracks(playlist)
      offset = 0
      raw_tracks = playlist.tracks(limit: 100, offset: offset)
      while raw_tracks.length > 0
        self.add_raw_tracks(raw_tracks)
        offset += 100
        raw_tracks = playlist.tracks(limit: 100, offset: offset)
      end
  end

  def all
    @tracks
  end
end
