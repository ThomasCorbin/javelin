require 'spec_helper'
require 'application_helper'

describe PagesController do
  render_views
  include ApplicationHelper

  describe "GET 'home'" do

    before(:each) do
      get :home
    end

    it "should be successful" do
      response.should be_success
    end

    it "should have the right title" do
      response.should have_selector("title",
                        :content => "#{title 'Home'}")
    end

    describe "when signed in" do

      before(:each) do
        @user       = test_sign_in(Factory(:user))
        other_user  = Factory(:user, :email => Factory.next(:email))

        other_user.follow!(@user)
      end

      it "should have the right follower/following counts" do
        get :home
        response.should have_selector("a", :href => following_user_path(@user),
                                           :content => "0 following")
        response.should have_selector("a", :href => followers_user_path(@user),
                                           :content => "1 follower")
      end
    end

    describe "microposts" do

      before(:each) do
        @user   = test_sign_in(Factory(:user))
        @admin  = Factory(:admin)

        (0..50).each do |i|
          Factory(:micropost, :user => @user, :content => "#{i}")
        end

        @other_user_micropost = Factory(:micropost, :user => @admin, :content => "other user micropost")
        @user.microposts << @other_user_micropost
      end

      it "should have an element for each micropost" do
        get 'home'
        @user.microposts[0..2].each do |micropost|
          response.should have_selector("span", :content => micropost.content)
        end
      end

      it "should paginate microposts" do
        get 'home'
        response.should have_selector("div.flickr_pagination")
        response.should have_selector("span.disabled", :content => "Previous")
        response.should have_selector("a", :href => "/?page=2",
                                           :content => "2")
        response.should have_selector("a", :href => "/?page=2",
                                           :content => "Next")
      end

      it "should NOT show the delete link posts NOT from the current user" do
        get 'home'

        response.should_not have_selector("a", :href    => "/microposts/#{@user.microposts.first.id}",
                                           :rel     => "nofollow",
                                           :content => "Delete")
      end

      it "should show the delete link for posts from the current user" do
        get 'home'

        response.should have_selector("a", :href    => "/microposts/#{@user.microposts[2].id}",
                                           :rel     => "nofollow",
                                           :content => "Delete")
      end
    end
  end


  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end

    it "should have the right title" do
      get 'contact'
      response.should have_selector("title",
                        :content => "#{title 'Contact'}")
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end

    it "should have the right title" do
      get 'about'
      response.should have_selector("title",
                        :content => "#{title 'About'}")
    end
  end

end

