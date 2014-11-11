enable :sessions

  post '/tweets/submit' do
    user = User.find(session[:id])
    tweet = user.tweets.create(text:params[:body], created_at: Time.now)

    redirect 'tweets/user_stream'
  end

  get '/tweets/user_stream' do
    user = User.find(session[:id])
    twitter_client = User.twitter_client(session[:id])
    @tweets = user.fetch_tweets(twitter_client)
    erb :'/users/tweets/view_all'
  end

