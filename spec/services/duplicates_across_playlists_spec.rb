require 'rails_helper'

describe 'Duplicates across playlists' do
  it "finds duplicates" do
      playlist1 = PlaylistCache.new('123')
      playlist2 = PlaylistCache.new('456')
      playlist3 = PlaylistCache.new('789')

      playlist1.add('abc')
      playlist1.add('def')
      playlist1.add('ghi')
      playlist1.add('ghi')

      playlist2.add('abc')

      playlist3.add('def')

      duplicates = DuplicatesAcrossPlaylists.new([playlist1, playlist2, playlist3])

      expect(duplicates.get()).to match_array(['abc' => ['123', '456'], 'def' => ['123', '789'], 'ghi' => ['123'] ])
  end
end
