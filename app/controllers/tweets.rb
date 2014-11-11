enable :sessions

  post '/tweets/submit' do
    twitter_client.update(params[:body])
    redirect 'tweets/user_stream'
  end

  get '/tweets/user_stream' do
    @tweets = twitter_client.user_timeline
    erb :'/tweets/view_all'
  end

