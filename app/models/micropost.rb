class Micropost < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :content, :upvotes, :downvotes, :inappropriate, :user_id

  has_many :be_upvoteds, foreign_key: "upvoted_id", class_name: "Upvote"
  has_many :upvoters, through: :be_upvoteds, source: :upvoter

  has_many :be_downvoteds, foreign_key: "downvoted_id", class_name: "Downvote"
  has_many :downvoters, through: :be_downvoteds, source: :downvoter

  has_many :voted_inappropriates, foreign_key: "inappropriate_voted_id",
                                  class_name: "Inappropriate"
  has_many :inappropriate_voters, through: :voted_inappropriates,
                                  source: :inappropriate_voter

  belongs_to :user

  ####################################
  ####################################
  ### before_save works not only #####
  ### when data is created, it works #
  ### every time the data is updated!#
  ####################################
  ####################################
  before_save :initialize_attributes

  def self.rank
    microposts = self.all
    ranked_microposts = microposts.sort_by { |micropost| micropost.score }
    ranked_microposts
  end

  def initialize_attributes
    self.upvotes = 0 unless self.upvotes
    self.downvotes = 0 unless self.downvotes
    self.inappropriate = 0 unless self.inappropriate
  end

  def whose?
    user_id = self.user_id
    User.find(user_id)
  end

  def score
    self.upvotes - self.downvotes
  end

end
