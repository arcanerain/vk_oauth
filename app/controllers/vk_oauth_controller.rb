class VkOauthController < ApplicationController
  def index
    @client_id = 2764053
    @redirect_uri = "http://strong-sword-9740.heroku.com/vk_oauth/callback"
    @display = "page" # popup
  end

  def callback
    @code = params[:code]
  end

  def logout

  end

end
