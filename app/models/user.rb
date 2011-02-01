# == Schema Information
# Schema version: 20110201000924
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)     not null
#  email      :string(255)     not null
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  attr_accessible :name, :email

  validates :name,  :presence   => true,
                    :length     => { :maximum => 50 }
  validates :email, :presence   => true,
                    :email      => true,
                    :uniqueness => { :case_sensitive => false }
end

