class SitesController < ApplicationController
    before_filter :signed_in_user, only: [:show, :index]

    def show
        #create_bookmark required for sidebar
        create_bookmark
        #use site_bookmarks method defined in user model.
        #send site_id to method, will use this with current user 
        #to only get bookmarks added by that user for a particular site
        @feed_items = current_user.site_bookmarks(params[:id])
        #Need @site to display site_host for title
        if @feed_items.any?
            @site = Sites.where("id = ?", params[:id])
        else
            #Need @feed_items for static_pages/home to render
            @feed_items = current_user.feed 
            flash[:error] = "You have no bookmarks for that site or site doesn't exist"
            render 'static_pages/home'
        end
    end

    def index
        #@bookmark required for sidebar
        if signed_in?
            @bookmark = current_user.bookmarks.build
        end
        #get unique sites where bookmark.user_id = user
        #sites_feed is defined in model 
        @sites_index = current_user.sites_feed
    end

end