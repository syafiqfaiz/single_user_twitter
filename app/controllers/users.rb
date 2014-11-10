enable :sessions



  use OmniAuth::Builder do
    provider :twitter, credentials["twitter_consumer_key"], credentials["twitter_consumer_secret"]
  end

  get '/login' do
    redirect to("/auth/twitter")
  end


  get '/auth/twitter/callback' do
    env['omniauth.auth'] ? session[:admin] = true : halt(401,'Not Authorized')

    current_user = User.find_by(uid: env['omniauth.auth']['info']['uid'])
    if current_user != nil
      current_user.last_login = Time.now
      current_user.login
    else
      new_user = User.new
      new_user.uid = env['omniauth.auth']['info']['uid']
      new_user.username = env['omniauth.auth']['info']['username']
      new_user.email = env['omniauth.auth']['info']['email']
      new_user.token = env['omniauth.auth']['credentials']['token']
      new_user.secret = env['omniauth.auth']['credentials']['secret']
      new_user.updated_at = Time.now
      new_user.created_at = Time.now
      new_user.save
    end
    redirect "/"
  end

  get '/auth/failure' do
    params[:message]
  end

