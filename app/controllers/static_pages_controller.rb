class StaticPagesController < ApplicationController
  def home
    if signed_in?
        @bookmark = current_user.bookmarks.build
        @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
end
