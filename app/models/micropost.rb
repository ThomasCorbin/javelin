
# == Schema Information
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  content    :text
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Micropost < ActiveRecord::Base

  cattr_reader :per_page
  @@per_page = 10

  attr_accessible :content

  belongs_to :user

  validates :content, :presence => true, :length => { :maximum => 140 }
  validates :user_id, :presence => true

  default_scope :order => 'microposts.created_at DESC'
end
