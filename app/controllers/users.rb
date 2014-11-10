enable :sessions

namespace '/user' do

  CONSUMER_KEY="consumer-key-from-twitter"
  CONSUMER_SECRET="consumer-secret-from-twitter"
  CALLBACK_URL="http://127.0.0.1/oauth/callback"


  get '/oauth/request_token' do
    consumer = OAuth::Consumer.new CONSUMER_KEY, CONSUMER_SECRET, :site => 'https://api.twitter.com'

    request_token = consumer.get_request_token :oauth_callback => CALLBACK_URL
    session[:request_token] = request_token.token
    session[:request_token_secret] = request_token.secret

    puts "request: #{session[:request_token]}, #{session[:request_token_secret]}"

    request_token.authorize_url
  end

  get '/oauth/callback' do
    consumer = OAuth::Consumer.new CONSUMER_KEY, CONSUMER_SECRET, :site => 'https://api.twitter.com'

    puts "CALLBACK: request: #{session[:request_token]}, #{session[:request_token_secret]}"

    request_token = OAuth::RequestToken.new consumer, session[:request_token], session[:request_token_secret]
    access_token = request_token.get_access_token :oauth_verifier => params[:oauth_verifier]

    Twitter.configure do |config|
      config.consumer_key = credentials["twitter_consumer_key"]
      config.consumer_secret = credentials["twitter_consumer_secret"]
      config.oauth_token = access_token.token
      config.oauth_token_secret = access_token.secret
    end

    "[#{Twitter.user.screen_name}] access_token: #{access_token.token}, secret: #{access_token.secret}"
  end

end