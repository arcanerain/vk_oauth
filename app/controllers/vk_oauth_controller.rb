class VkOauthController < ApplicationController
  def index
    @client_id = 2764053
    @redirect_uri = "http://localhost:3000/callback"
    @display = "page" # popup
  end

  def callback
  end

  def logout
  end

end
