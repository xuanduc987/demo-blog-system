class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @feed_items = current_user.feed.paginate(page: params[:page])
      @entry = current_user.entries.build
    else
      @feed_items = Entry.all.paginate(page: params[:page])
    end
  end
end
