require "rails_helper"

RSpec.describe PlaylistController, :type => :controller do
  describe 'get playlist' do
    it "gets a playlist" do
      get :show, params: {id: '1ucwF3xYMXzeikqnT88CTh'}
    end
  end
end
