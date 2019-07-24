class TrackCollection
  @playlist_id
  @playlist_cache
  @song_cache
  @track = []

  def initialize(playlist_id)
    @playlist_id = playlist_id
    @playlist_cache = PlaylistCache.new(@playlist_id)
    @song_cache = SongCache.new
    @tracks = []
  end

  def self.add_raw_tracks(raw_tracks)
    new_tracks = raw_tracks.map do |track|
      Track.new(track.id, track.name)
    end
    @tracks.concat(new_tracks)
  end

  def get_playlist_tracks(playlist, offset = 1)
      raw_tracks = playlist.tracks(limit: 100, offset: offset)
      if raw_tracks.length > 0
        @song_cache.add_tracks(raw_tracks)

        @playlist_cache.add_tracks(raw_tracks)
        self.get_playlist_tracks(playlist, offset += 100)
      end
      @tracks
  end

  def clear_cache
    @playlist_cache.clear
  end

  def all
    @playlist_cache.get
  end

  def count
    @playlist_cache.count
  end

  def duplicates
    @playlist_cache.duplicates
  end
end
