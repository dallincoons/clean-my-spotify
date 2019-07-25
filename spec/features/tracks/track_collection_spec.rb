require 'rails_helper'

describe 'Track Collection' do
  it "gets hydrates track collection" do
    track_collection = TrackCollection.new(PlaylistMock.new)
    track_collection.clear_cache

    track_collection.hydrate

    expect(track_collection.all.length).to eq(4)
  end

  it "if count is the same as total, songs are pulled from cache" do
    track_collection = TrackCollection.new(PlaylistMock.new)
    track_collection.clear_cache

    track_collection.hydrate

    track_collection = TrackCollection.new(PlaylistMock2.new)

    expect(track_collection.all.length).to eq(4)
  end

  it "if count is different from total, cache is cleared" do
    track_collection = TrackCollection.new(PlaylistMock.new)
    track_collection.clear_cache

    track_collection.hydrate

    track_collection = TrackCollection.new(PlaylistMock3.new)

    track_collection.hydrate

    expect(track_collection.all.length).to eq(3)
  end
end

class PlaylistMock
  attr_accessor :id

  def initialize()
    @id = '1234'
    @tracks_ran = 0
  end

  def total
    4
  end

  def tracks(limit:limit, offset:offset)
    if @tracks_ran === 0
      @tracks_ran += 1
      [
        OpenStruct.new(
          :id => '138',
          :name => 'Misfits'
        ),
        OpenStruct.new(
          :id => '139',
          :name => 'New Misfits'
        ),
        OpenStruct.new(
          :id => '140',
          :name => 'New New Misfits'
        ),
    ]
    elsif @tracks_ran === 1
      @tracks_ran += 1
      [
        OpenStruct.new(
            :id => '141',
            :name => 'New New Misfits'
        )
      ]
    else
      []
    end
  end
end

class PlaylistMock2
  attr_accessor :id

  def initialize()
    @id = '1234'
    @tracks_ran = 0
  end

  def total
    4
  end

  def count
    3
  end
end

class PlaylistMock3
  attr_accessor :id

  def initialize()
    @id = '1234'
    @tracks_ran = 0
  end

  def total
    4
  end

  def count
    2
  end

  def tracks(limit:limit, offset:offset)
    if @tracks_ran === 0
      @tracks_ran += 1
      [
          OpenStruct.new(
              :id => '138',
              :name => 'Misfits'
          ),
          OpenStruct.new(
              :id => '139',
              :name => 'New Misfits'
          ),
      ]
    elsif @tracks_ran === 1
      @tracks_ran += 1
      [
          OpenStruct.new(
              :id => '141',
              :name => 'New New Misfits'
          )
      ]
    else
      []
    end
  end
end
