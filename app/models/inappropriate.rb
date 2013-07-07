class Inappropriate < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :inappropriate_voter_id, :inappropriate_voted_id

  belongs_to :inappropriate_voter, class_name: "User"
  belongs_to :inappropriate_voted, class_name: "Micropost"
end
