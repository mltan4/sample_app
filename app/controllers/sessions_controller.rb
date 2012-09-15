class SessionsController < ApplicationController

#Listing 8.3

  def new 
  end

  def create #Listing 8.10
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Sign the user in and redirect to the user's show page.
    	sign_in user #Listing 8.13
      	redirect_to user
    else #.now is Listing 8.11
      flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy
  	sign_out
    redirect_to root_url
  end

end
