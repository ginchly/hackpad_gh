class BookmarksController < ApplicationController
    before_filter :signed_in_user, only: [:create, :destroy]
    before_filter :correct_user, only: :destroy

    def create
        @bookmark = current_user.bookmarks.build(params[:bookmark])
        if @bookmark.save
            flash[:success] = "Bookmark created!"
            redirect_to root_path
        else
            #Need @feed_items for static_pages/home to render
            @feed_items = current_user.feed 
            render 'static_pages/home'
        end
    end

    def destroy
        @bookmark.destroy
        redirect_to root_path
    end

    def show
        @user = current_user
        create_bookmark
        @show_bookmark = Bookmark.find(params[:id])
        
       
       #Use rescue is trying to navigate to bookmark that doesn't exist
      rescue
        #Need @feed_items for static_pages/home to render
        @feed_items = current_user.feed 
        flash[:error] = "Bookmark does not exist or has been deleted"
        render 'static_pages/home'
    end

    private
        def correct_user
            @bookmark = current_user.bookmarks.find_by_id(params[:id])
            redirect_to root_path if @bookmark.nil?
        end

end
