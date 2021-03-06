enable :sessions


  credentials = YAML.load(File.open("config/credentials.yaml"))
  use OmniAuth::Builder do
    provider :twitter, credentials["twitter_consumer_key"], credentials["twitter_consumer_secret"]
  end

  get '/login' do
    redirect to("/auth/twitter")
  end


  get '/auth/twitter/callback' do
    env['omniauth.auth'] ? session[:admin] = true : halt(401,'Not Authorized')

    current_user = User.find_by(uid: env['omniauth.auth']['uid'])
    if current_user != nil
      current_user.updated_at = Time.now
      session[:id] = current_user.id

    else
      new_user = User.new
      new_user.uid = env['omniauth.auth']['uid']
      new_user.name = env['omniauth.auth']['info']['name']
      new_user.token = env['omniauth.auth']['credentials']['token']
      new_user.secret = env['omniauth.auth']['credentials']['secret']
      new_user.updated_at = Time.now
      new_user.created_at = Time.now
      new_user.save
      session[:id] = new_user.id

    end
    redirect "/"
  end

  get '/auth/failure' do
    params[:message]
  end

