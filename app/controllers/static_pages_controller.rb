class StaticPagesController < ApplicationController
  def home
    if signed_in?
        @bookmark = current_user.bookmarks.build
        @feed_items = current_user.feed  #.paginate(page: params[:page])  <%= will_paginate @feed_items %>
    end
  end
end
