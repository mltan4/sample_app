class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy] #Listing 9.12?
  before_filter :correct_user,   only: [:edit, :update] #Listing 9.15
  before_filter :admin_user,     only: :destroy
  
    def show
      @user = User.find(params[:id])
      @microposts = @user.microposts.paginate(page: params[:page])
    end
    
    def destroy
      User.find(params[:id]).destroy
      flash[:success] = "User destroyed."
      redirect_to users_url
    end
    
    def new
    	@user = User.new
    end
    
    def index
      #@users = User.all  #Taken out in 9.22
      @users = User.paginate(page: params[:page]) #replaced above 9.35, paginate
    end

    def create
      @user = User.new(params[:user])
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to the Sample App!"
        redirect_to @user
      else
        render 'new'
      end
    end

    def edit #Listing 9.2 The user edit form
      #@user = User.find(params[:id]) #filtered out in 9.15
    end
    
    def update #Listing 9.8 The initial user update action. 
      #@user = User.find(params[:id]) #filtered out in 9.15
      if @user.update_attributes(params[:user])
        # Handle a successful update.
        flash[:success] = "Profile updated" #Listing 9.10
        sign_in @user
        redirect_to @user
      else
        render 'edit'
      end
    end

    private

    def signed_in_user #Listing 9.12
      unless signed_in? #Listing 9.19
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end   
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end