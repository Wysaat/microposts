class Downvote < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :downvoter_id, :downvoted_id

  belongs_to :downvoter, class_name: "User"
  belongs_to :downvoted, class_name: "Micropost"
end
