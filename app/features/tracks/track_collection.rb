class TrackCollection
  MAX_LIMIT = 100

  @playlist_id
  @playlist_cache
  @song_cache
  @track = []

  def initialize(playlist)
    @playlist = playlist
    @playlist_cache = PlaylistCache.new(@playlist.id)
    @song_cache = SongCache.new
    @tracks = []
  end

  def hydrate
    if @playlist.total != self.count + 1
      self.clear_cache
      self.get_playlist_tracks
    end
    self
  end

  def self.add_raw_tracks(raw_tracks)
    new_tracks = raw_tracks.map do |track|
      Track.new(track.id, track.name)
    end
    @tracks.concat(new_tracks)
  end

  def get_playlist_tracks(offset = 1)
      raw_tracks = @playlist.tracks(limit: TrackCollection::MAX_LIMIT, offset: offset)
      if raw_tracks.length > 0
        @song_cache.add_tracks(raw_tracks)

        @playlist_cache.add_tracks(raw_tracks)
        self.get_playlist_tracks(offset += TrackCollection::MAX_LIMIT)
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
