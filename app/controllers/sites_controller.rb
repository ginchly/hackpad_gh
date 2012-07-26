class SitesController < ApplicationController
    before_filter :signed_in_user, only: [:show, :index]

    def show
        @bookmark = current_user.bookmarks.build
        @feed_items = current_user.site_bookmarks(params[:id])
        @site = Sites.where("id = ?", params[:id])
    end

    def index
        if signed_in?
            @bookmark = current_user.bookmarks.build
        end
        #get unique sites where bookmark.user_id = user
        #sites_feed is defined in model 
        @sites_index = current_user.sites_feed
    end

end