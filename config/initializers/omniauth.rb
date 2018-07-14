require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, "5020ab65e17441d69837c43c1d82d791", "3e37707325b44247895d80abc9c4e89a", scope: 'user-read-email playlist-modify-public user-library-read user-library-modify'
end