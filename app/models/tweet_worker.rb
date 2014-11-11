class TweetWorker < ActiveRecord::Base
  include Sidekiq::Worker

  def self.perform(tweet_id)
    tweet = Tweet.find(tweet_id)
    user = tweet.user
    twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = CONSUMER_KEY
      config.consumer_secret     = CONSUMER_SECRET
      config.access_token        = user.token
      config.access_token_secret = user.secret
    end
    twitter_client.update(tweet.text)
  end
end
