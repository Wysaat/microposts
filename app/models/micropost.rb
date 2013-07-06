class Micropost < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :content, :upvotes, :downvotes, :inappropriate, :user_id

  has_many :be_upvoted, foreign_key: "upvoted_id", class_name: "Upvote"
  has_many :upvoters, through: :be_upvoteds, source: :upvoter

  belongs_to :user

  ####################################
  ####################################
  ### before_save works not only #####
  ### when data is created, it works #
  ### every time the data is updated!#
  ####################################
  ####################################
  before_save :initialize_attributes

  def initialize_attributes
    unless self.upvotes
      self.upvotes = 0
    end
    unless self.downvotes
      self.downvotes = 0
    end
    unless self.inappropriate
      self.inappropriate = 0
    end
  end

  def whose?
    user_id = self.user_id
    User.find(user_id)
  end

end
