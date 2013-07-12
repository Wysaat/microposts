class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :admin, :GoodOrBad,
                  :followers_num, :followings_num
  has_secure_password

  validates(:name, { :presence => true })
  # validates :password, presence: true, { :length => { :minimum => 8 } }
  validates :password, presence: true, length: {minimum: 8}

  EMAIL = /\A\w*@\w*\.[a-z]*(\.[a-z]*)?\z/i
  validates :email, presence: true, format: {with: EMAIL},
            uniqueness: {case_sensitive: false}

  ######################################################################
  ######################################################################
  ## it must be before_create, if it's before_save, then can't #########
  ## update current_user, which will cause weird things        #########
  ######################################################################
  ######################################################################
  before_create :create_remember_token

  before_save :num_init

  has_many :microposts

  has_many :relations, foreign_key: "follower"
  has_many :followees, through: :relations, source: :followees

  has_many :reverse_relations, foreign_key: "followee", class_name: "Relation"
  has_many :followers, through: :reverse_relations, source: :followers

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
    # an alternative way
  # has_many :followed_users, through: :relationships, source: :followed
  has_many :followeds, through: :relationships

  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name: "Relationship",
                                   dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  ######################################################################
  ######################################################################
  ### the following must be "upvoter_id", or will raise a type error ###
  ######################################################################
  ######################################################################
  has_many :upvotes, foreign_key: "upvoter_id"
  has_many :upvoteds, through: :upvotes, source: :upvoted

  has_many :downvotes, foreign_key: "downvoter_id"
  has_many :downvoteds, through: :downvotes, source: :downvoted

  has_many :inappropriates, foreign_key: "inappropriate_voter_id"
  has_many :inappropriate_voteds, through: :inappropriates,
                                 source: :inappropriate_voted

  #def follow!(other_user)
  # relations.create!(followed: other_user.name)
  #end

    # all 'self's can be omitted
    def following?(other_user)
      self.relationships.find_by_followed_id(other_user.id)
    end
    
    ###############################################################################
    ################ follow should update sth                      ################
    ################ and don't forget the unfollow counterpart !!! ################
    ###############################################################################
    def follow!(other_user)
      self.relationships.create!(followed_id: other_user.id)
      self.update_attribute(:followings_num, self.followings_num + 1)
      other_user.update_attribute(:followers_num, other_user.followers_num + 1)
    end

    def unfollow!(other_user)
      self.relationships.find_by_followed_id(other_user.id).destroy
      self.update_attribute(:followings_num, self.followings_num - 1)
      other_user.update_attribute(:followers_num, other_user.followers_num - 1)
    end

    def he_is_good!(other_user)
        other_user.update_attribute(:GoodOrBad, true)
    end

    def he_is_bad!(other_user)
        other_user.update_attribute(:GoodOrBad, false)
    end

    def upvote!(micropost)
      self.upvotes.create!(upvoted_id: micropost.id)
    end

    def has_upvoted?(micropost)
      self.upvotes.find_by_upvoted_id(micropost.id)
    end

    def downvote!(micropost)
      self.downvotes.create!(downvoted_id: micropost.id)
    end

    def has_downvoted?(micropost)
      self.downvotes.find_by_downvoted_id(micropost.id)
    end

    def inappropriate!(micropost)
      self.inappropriates.create(inappropriate_voted_id: micropost.id)
    end

    def has_voted_inappropriate?(micropost)
      self.inappropriates.find_by_inappropriate_voted_id(micropost.id)
    end

    def microposts_score
      score = 0
      self.microposts.each { |micropost| score += micropost.score }
      score
    end

    def self.rank
      self.all.sort { |user| user.microposts_score }
    end

##################################################################################
##################################################################################
############# the following two methods are very slow and shoud ##################
############# not be used unlessed fully understood             ##################
##################################################################################
##################################################################################
    def followings
      followings = []
      User.all.each do |user|
        followings << user if self.following?(user)
      end
      followings
    end

    def followers
      followers = []
      User.all.each do |user|
        followers << user if user.following?(self)
      end
      followers
    end
##################################################################################
##################################################################################
##################################################################################

    def num_init
      self.followers_num = 0 unless self.followers_num
      self.followings_num = 0 unless self.followings_num
    end


  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

end
