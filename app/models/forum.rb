class Forum < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :topics_num

  has_many :topics, foreign_key: "forum_id"

  before_create :num_init

  def num_init
    self.topics_num = 0
  end

  def update_topics_num
    self.update_attribute(:topics_num, self.topics_num + 1)
  end
end
