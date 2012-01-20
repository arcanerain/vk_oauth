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
    json_token = open("https://oauth.vkontakte.ru/access_token?client_id="+CLIENT_ID.to_s+"&client_secret="+CLIENT_SECRET+"&code="+@code)
    @parsed_json_token_data = ActiveSupport::JSON.decode(json_token)

    if(!@parsed_json_token_data["error"].present?)
      json_friends = open("https://api.vkontakte.ru/method/friends.get?uid="+@parsed_json_token_data["user_id"].to_s+"&access_token="+@parsed_json_token_data["access_token"].to_s)
      @parsed_json_friends = ActiveSupport::JSON.decode(json_friends)
    end

  end

  def logout
  end

end
