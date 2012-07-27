class StaticPagesController < ApplicationController
  def home
    #Home page view is list of users bookmarks, ordered by creation date/time
    #Could alternatively make a feed of bookmarks from all users
    if signed_in?
        create_bookmark
        @feed_items = current_user.feed 
        #.paginate(page: params[:page])  <%= will_paginate @feed_items %>
    end
  end
end
