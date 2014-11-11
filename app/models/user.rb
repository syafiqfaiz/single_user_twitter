class User < ActiveRecord::Base

  def twitter_client(token,secret)
      twitter_client = Twitter::REST::Client.new do |config|
        config.consumer_key        = consumer_key
        config.consumer_secret     = consumer_secret
        config.access_token        = token
        config.access_token_secret = secret
      end

      twitter_client
  end

end