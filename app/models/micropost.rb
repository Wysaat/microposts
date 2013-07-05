class Micropost < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :content, :upvotes, :downvotes, :inappropriate

  belongs_to :user

  before_save :initialize_attributes

  def initialize_attributes
    self.upvotes = 0
    self.downvotes = 0
    self.inappropriate = 0
  end
end
