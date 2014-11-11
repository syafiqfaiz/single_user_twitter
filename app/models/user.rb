class User < ActiveRecord::Base

  def login(id)
    logged_user = User.find(id)
    session[:token] = logged_user.token
    session[:secret] = logged_user.secret
  end

end