class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:show]

  def show
    #Will show public profile page, this should be visible to any signed in user
    #create bookmark required for sidebar
      create_bookmark
      @user = User.find(params[:id])

  #Use rescue is trying to navigate to user that doesn't exist
  rescue
    #Need @feed_items for static_pages/home to render
    @feed_items = current_user.feed 
    flash[:error] = "User does not exist"
    render 'static_pages/home'
 
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
        sign_in @user
        flash[:success] = "Thanks for joining!"
        redirect_to @user
    else
        render 'new'
    end
  end

end
