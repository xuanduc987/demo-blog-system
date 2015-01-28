class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 5)
      @entry = current_user.entries.build
    else
      @feed_items = Entry.all.paginate(page: params[:page], per_page: 5)
    end
  end
end
