class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @bookmarks = @user.bookmarks.paginate(page: params[:page])
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
