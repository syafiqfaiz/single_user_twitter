enable :sessions
namespace '/tweets' do
  post '/submit' do
    $user = Twitter::REST::Client.new do |config|
      config.consumer_key        = "K679OFUQmtPucB0ztkPG6VS6F"
      config.consumer_secret     = "w6YWCmOGfr0O8GSjR7z2Ep64PdAdLL10HnktnQVMZWeLN2wUGz"
      config.access_token        = session[:token]
      config.access_token_secret = session[:secret]
    end
    $user.update(params[:body])
    redirect 'tweets/user_stream'
  end

  get '/user_stream' do
    @tweets = $user.timeline('syafiqfaizfr')
    erb :'/tweets/view_all'
  end

end