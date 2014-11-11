enable :sessions
credentials = YAML.load(File.open("config/credentials.yaml"))
  post '/tweets/submit' do
    $user = Twitter::REST::Client.new do |config|
      config.consumer_key        = credentials["twitter_consumer_key"]
      config.consumer_secret     = credentials["twitter_consumer_secret"]
      config.access_token        = session[:token]
      config.access_token_secret = session[:secret]
    end
    $user.update(params[:body])
    redirect 'tweets/user_stream'
  end

  get '/tweets/user_stream' do
    $user = Twitter::REST::Client.new do |config|
      config.consumer_key        = credentials["twitter_consumer_key"]
      config.consumer_secret     = credentials["twitter_consumer_secret"]
      config.access_token        = session[:token]
      config.access_token_secret = session[:secret]
    end
    @tweets = $user.timeline('syafiqfaizfr')
    erb :'/tweets/view_all'
  end

