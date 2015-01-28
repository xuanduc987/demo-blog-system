class StaticPagesController < ApplicationController
  def home
    @entry = current_user.entries.build if logged_in?
  end
end
