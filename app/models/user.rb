require 'digest'

class User < ActiveRecord::Base

  cattr_reader :per_page
  @@per_page = 15

  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation

  validates :name,  :presence   => true,
                    :length     => { :maximum => 50 }
  validates :email, :presence   => true,
                    :email      => true,
                    :uniqueness => { :case_sensitive => false }

  # Automatically create the virtual attribute 'password_confirmation'.
  validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..40 }


  before_save :encrypt_password

  has_many :microposts,                 :dependent    => :destroy
  has_many :user_relationships,         :foreign_key  => "follower_id",
                                        :dependent    => :destroy
  has_many :following,                  :through      => :user_relationships,
                                        :source       => :followed


  has_many :reverse_user_relationships, :foreign_key  => "followed_id",
                                        :class_name   => "UserRelationship",
                                        :dependent    => :destroy
  has_many :followers,                  :through      => :reverse_user_relationships,
                                        :source       => :follower


  # Return true if the user's password matches the submitted password.
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  def following?(followed)
    user_relationships.find_by_followed_id(followed)
  end

  def follow!(followed)
    user_relationships.create!(:followed_id => followed.id)
  end

  def unfollow!(followed)
    user_relationships.find_by_followed_id(followed).destroy
  end

  def feed
    # This is preliminary. See Chapter 12 for the full implementation.
#    Micropost.where("user_id = ?", id)
    Micropost.from_users_followed_by( self )
  end

  private

    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end


# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)     not null
#  email              :string(255)     not null
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean         default(FALSE)
#

