class User < ActiveRecord::Base

  def self.twitter_client(user_id)
    user = User.find(user_id)
      twitter_client = Twitter::REST::Client.new do |config|
        config.consumer_key        = CONSUMER_KEY
        config.consumer_secret     = CONSUMER_SECRET
        config.access_token        = user.token
        config.access_token_secret = user.secret
      end

      twitter_client
  end

end