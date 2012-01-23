require 'open-uri'
class VkOauthController < ApplicationController
  CLIENT_ID = 2764053
  CLIENT_SECRET = "hWXCwCTpBHIGXYg07P7D"
  CALLBACK_URL = "http://strong-sword-9740.heroku.com/vk_oauth/callback"

  def index
    @client_id = CLIENT_ID.to_s
    @redirect_uri = CALLBACK_URL
    @display = "page" # popup
    @scope = "friends,wall,offline"
  end

  def callback
    @code = params[:code]
    #with a code trying to get an access_token
    json_token = open("https://oauth.vkontakte.ru/access_token?client_id="+CLIENT_ID.to_s+"&client_secret="+CLIENT_SECRET+"&code="+@code)
    @parsed_json_token_data = ActiveSupport::JSON.decode(json_token)

    if(!@parsed_json_token_data["error"].present?)
      json_friends = open("https://api.vkontakte.ru/method/friends.get?uid="+@parsed_json_token_data["user_id"].to_s+"&fields=first_name,last_name,nickname,sex,bdate,city,country,timezone,photo,photo_medium,photo_big,domain,has_mobile,rate,contacts,education&access_token="+@parsed_json_token_data["access_token"].to_s)
      @parsed_json_friends = ActiveSupport::JSON.decode(json_friends)
    end

  end

  def post
    message = URI::encode("Test of the wall.post function through OAuth 2 access token")
    if(!params[:access_token].nil?)
      json_wall_post = open("https://api.vkontakte.ru/method/wall.post?message="+message+"&access_token="+params[:access_token].to_s)
      @result = ActiveSupport::JSON.decode(json_wall_post)
    else
      @result = "Access token is nil"
    end
  end

  def postsave
    message = URI::encode("Test of the wall.savePost function through OAuth 2 access token")
    if(!params[:access_token].nil? && !params[:wall_id].nil?)
      json_wall_post = open("https://api.vkontakte.ru/method/wall.savePost?wall_id="+params[:wall_id].to_s+"&message="+message+"&photo_id=6534676_276215237&access_token="+params[:access_token].to_s)
      @result = ActiveSupport::JSON.decode(json_wall_post)
    else
      @result = "Access token is nil"
    end
  end

  def notification
    message = URI::encode("TesT")
    if(!params[:access_token].nil? && !params[:uid].nil?)
      #json_send_notif = open("https://api.vkontakte.ru/method/secure.sendNotification?uids="+params[:uid].to_s+"&message="+message+"&random="+rand(9999).to_s+"&timestamp="+Time.now.to_i.to_s+"&access_token="+params[:access_token].to_s+"&client_secret="+CLIENT_SECRET)
      @url = "https://api.vkontakte.ru/api.php?api_id="+CLIENT_ID.to_s+"&method=secure.sendNotification&uids="+params[:uid].to_s+"&message="+message+"&random="+rand(99999999).to_s+"&timestamp="+Time.now.to_i.to_s+"&access_token="+params[:access_token].to_s+"&format=JSON"
      json_send_notif = open(@url)
      @result = ActiveSupport::JSON.decode(json_send_notif)
    else
      @result = "Access token is nil"
    end
  end

  def logout
  end

end
