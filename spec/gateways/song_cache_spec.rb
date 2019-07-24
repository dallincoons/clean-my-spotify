require 'rails_helper'

describe 'Playlist Cache' do
  it "finds duplicate" do
      playlist = PlaylistCache.new('1234')

      $redis.flushall()

      playlist.add('abc')
      playlist.add('abc')
      playlist.add('def')

      expect(playlist.duplicates).to match_array(['abc'])
  end
end
