class Topic < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :comments_num

  belongs_to :owner, class_name: "User"
  belongs_to :forum, class_name: "Forum"

  has_many :comments

  before_create :num_init

  def num_init
    self.comments_num = 0
  end

  def update_comments_num
    self.update_attribute(:comments_num, self.comments_num + 1)
  end
end
