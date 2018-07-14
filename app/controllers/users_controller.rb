class UsersController < ApplicationController
	def spotify
        session[:spotify_auth] = request.env['omniauth.auth']

        redirect_to :controller => 'playlist', :action => 'index'
	end
end
