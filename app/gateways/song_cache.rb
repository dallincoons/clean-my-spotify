class SongCache
  def add_tracks(songs)
    songs.each do |song|
      self.add(song)
    end
  end

  def add(song)
    $redis.hmset(song.id, 'name', song.name)
  end

  def getSong(song_id)
    $redis.hgetall(song_id)
  end
end
