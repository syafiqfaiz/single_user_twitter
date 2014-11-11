class User < ActiveRecord::Base

  has_many :tweets

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

  def fetch_tweets(twitter_client)
    if self.tweets == nil
      twitter_client.user_timeline.each do |tweet|
        self.tweets.create(text: tweet.text, created_at: Time.now)
        self.updated_at = Time.now
      end
      self.tweets.last(10)
    elsif  Time.now - self.updated_at < 1.hour
      self.tweets.last(10)
    else
      twitter_client.user_timeline.each do |tweet|
        self.tweets.create(text: tweet.text, created_at: Time.now)
        self.updated_at = Time.now
      end
      self.tweets.last(10)
    end
  end

  def tweet(status)
    tweet = tweets.create!(:status => status)
    TweetWorker.perform_async(tweet.id)
  end

end