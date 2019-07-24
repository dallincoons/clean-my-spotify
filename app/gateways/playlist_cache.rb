class PlaylistCache
  attr_accessor :playlist_id

  @playlist_id
  @duplicates

  def initialize(playlist_id)
    @playlist_id = playlist_id
    @duplicates = []
  end

  def add_tracks(songs)
    songs.each do |song|
      $redis.incr(@playlist_id + ':count')
      self.add(song.id)
    end
  end

  def add(song_id)
    if $redis.sismember(@playlist_id, song_id) === true
      @duplicates.push(song_id)
    end
    $redis.sadd(@playlist_id, song_id)
    self.cache_duplicates
  end

  def get()
    $redis.smembers(@playlist_id)
  end

  def count()
    $redis.get(@playlist_id + ':count').to_i
  end

  def cache_duplicates
    @duplicates.each do |duplicate|
      $redis.sadd(@playlist_id + ':duplicates', duplicate)
    end
  end

  def duplicates
    $redis.smembers(@playlist_id + ':duplicates')
  end

  def clear
    $redis.del(@playlist_id + ':count')
    $redis.del(@playlist_id)
    $redis.del(@playlist_id + ':duplicates')
  end
end
