enable :sessions

# namespace '/user' do

  use OmniAuth::Builder do
    provider :twitter, "K679OFUQmtPucB0ztkPG6VS6F", "w6YWCmOGfr0O8GSjR7z2Ep64PdAdLL10HnktnQVMZWeLN2wUGz"
  end

  get '/login' do
    redirect to("/auth/twitter")
  end


  get '/auth/twitter/callback' do
    env['omniauth.auth'] ? session[:admin] = true : halt(401,'Not Authorized')
    session[:token] = env['omniauth.auth']['credentials']['token']
    session[:secret] = env['omniauth.auth']['credentials']['secret']
    redirect "/"
  end

  get '/auth/failure' do
    params[:message]
  end

# end