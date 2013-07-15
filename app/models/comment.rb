class Comment < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :owner, class_name: "User"
  belongs_to :topic
end
