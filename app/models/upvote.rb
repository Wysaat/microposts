class Upvote < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_accessible :upvoter_id, :upvoted_id

  belongs_to :upvoter, class_name: "User"
  belongs_to :upvoted, class_name: "Micropost"

end
