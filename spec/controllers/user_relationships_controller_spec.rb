require 'spec_helper'



describe UserRelationshipsController do

  describe "access control" do

    it "should require signin for create" do
      post :create
      response.should redirect_to(signin_path)
    end

    it "should require signin for destroy" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end

  describe "POST 'create'" do

    before(:each) do
      @user     = test_sign_in(Factory(:user))
      @followed = Factory(:user, :email => Factory.next(:email))
    end

    it "should create a relationship" do
      lambda do
        post :create, :user_relationship => { :followed_id => @followed }
        response.should be_redirect
      end.should change(UserRelationship, :count).by(1)
    end

    it "should create a relationship using Ajax" do
      lambda do
        xhr :post, :create, :user_relationship => { :followed_id => @followed }
        response.should be_success
      end.should change(UserRelationship, :count).by(1)
    end
  end

  describe "DELETE 'destroy'" do

    before(:each) do
      @user         = test_sign_in(Factory(:user))
      @followed     = Factory(:user, :email => Factory.next(:email))
      @user.follow!(@followed)

      @relationship = @user.user_relationships.find_by_followed_id(@followed)
    end

    it "should destroy a relationship" do
      lambda do
        delete :destroy, :id => @relationship
        response.should be_redirect
      end.should change(UserRelationship, :count).by(-1)
    end

    it "should destroy a relationship using Ajax" do
      lambda do
        xhr :delete, :destroy, :id => @relationship
        response.should be_success
      end.should change(UserRelationship, :count).by(-1)
    end
  end
end
