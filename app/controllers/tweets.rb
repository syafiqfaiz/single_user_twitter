enable :sessions

  post '/tweets/submit' do
    twitter_client = User.twitter_client(session[:id])
    twitter_client.update(params[:body])
    redirect 'tweets/user_stream'
  end

  get '/tweets/user_stream' do
    twitter_client = User.twitter_client(session[:id])
    @tweets = twitter_client.user_timeline
    erb :'/users/tweets/view_all'
  end

