require 'open-uri'
class VkOauthController < ApplicationController
  CLIENT_ID = 2764053
  CLIENT_SECRET = "hWXCwCTpBHIGXYg07P7D"
  URL = "http://strong-sword-9740.heroku.com/vk_oauth/callback"

  def index
    @client_id = CLIENT_ID
    @redirect_uri = URL
    @display = "page" # popup
    @scope = "friends,wall,offline"
  end

  def callback
    @code = params[:code]
    #with a code trying to get an access_token
    json_token = open("https://oauth.vkontakte.ru/access_token?client_id="+CLIENT_ID.to_s+"&client_secret="+CLIENT_SECRET+"&code="+code)
    @parsed_json_token_data = ActiveSupport::JSON.decode(json_token)
  end

  def logout
  end

end
