class MicropostsController < ApplicationController
#  before_filter :add_log
  before_filter :authenticate
  before_filter :authorized_user, :only => :destroy

  def index
    puts "Microposts.index params: #{params}"
#    @user = User.find( params[:user_id] )

    @user       = current_user
    @microposts = current_user.microposts.paginate :page => params[:page], :per_page => 5
  end

  def create
    @micropost  = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost destroyed!"
    redirect_back_or root_path
  end

  private

    def authorized_user
      @micropost = Micropost.find(params[:id])
      redirect_to root_path unless current_user?(@micropost.user)
    end
end
