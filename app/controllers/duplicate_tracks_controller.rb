require 'json'

class DuplicateTracksController < ApplicationController
  protect_from_forgery prepend: true

  def show
    @playlistid = params[:id]

    spotify = SpotifyGateway.new(session[:spotify_auth])

    playlist = spotify.get_playlist(@playlistid)

    tracks = TrackCollection.new(playlist).hydrate

    @playlist = playlist
    @duplicate_tracks =  tracks.duplicates.map do |song_id|
      Track.new(song_id, $redis.hget(song_id, 'name'))
    end

    render :json => @duplicate_tracks
  end

  def delete
    spotify = SpotifyGateway.new(session[:spotify_auth])

    spotify.remove_duplicate_tracks(params[:id], params[:duplicate_tracks])

    render json: {}, status: 200
  end
end
