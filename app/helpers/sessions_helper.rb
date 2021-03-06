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

  def current_user?(user) #Listing 9.16
    user == current_user
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default) #Listing 9.18
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end

end