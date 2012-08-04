class UsersController < ApplicationController

Pusher.app_id = '25258'
Pusher.key = '4e245534166218fe9521'
Pusher.secret = '25c3d35b733fb28b6bab'
  
def show
    #Will show public profile page, this should be visible to any signed in user
    #create bookmark required for sidebar
      @user = User.find(params[:id])

  #Use rescue is trying to navigate to user that doesn't exist
  rescue
    #Need @feed_items for static_pages/home to render
    flash[:error] = "User does not exist"
    render 'static_pages/home'
 
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.status = "Just joined"
    if @user.save
        sign_in @user
        flash[:success] = "Thanks for joining!"
        redirect_to root_path
    else
        render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if current_user.update_attributes(params[:user])
      #handle a successful update
      data = {'message' => current_user.status, 'user' => current_user.name}
      Pusher['hackPad'].trigger('status_update', data)
      sign_in current_user
      flash[:success] = "Status updated"
      redirect_to root_path
      else
      render 'edit'
    end
  end


end
