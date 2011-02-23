class PagesController < ApplicationController
  def home
    @title      = 'Home'
    @micropost  = Micropost.new if signed_in?

    if current_user.nil?
      @feed_items = []
    else
      @feed_items = current_user.feed.paginate :page => params[:page], :per_page => 5
    end
  end

  def contact
    @title = 'Contact'
  end

  def about
    @title = 'About'
  end

  def help
    @title = 'Help'
  end
end
