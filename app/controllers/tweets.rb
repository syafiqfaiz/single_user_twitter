enable :sessions

  post '/tweets/submit' do
    twitter_client = User.twitter_client(session[:id])
    twitter_client.update(params[:body])
    redirect 'tweets/user_stream'
  end

  get '/tweets/user_stream' do
    user = User.find(session[:id])
    twitter_client = User.twitter_client(session[:id])
    @tweets = user.fetch_tweets(twitter_client)
    erb :'/users/tweets/view_all'
  end

