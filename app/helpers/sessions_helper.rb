module SessionsHelper

  def sign_in(user) #Listing 8.19
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user) #Listing 8.20
    @current_user = user
  end

  def current_user #Listing 8.22
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
  
end
