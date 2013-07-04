class User < ActiveRecord::Base
	attr_accessible :name, :email, :password, :password_confirmation, :admin, :GoodOrBad
	has_secure_password

	validates(:name, { :presence => true })
	# validates :password, presence: true, { :length => { :minimum => 8 } }
	validates :password, presence: true, length: {minimum: 8}

	EMAIL = /\A\w*@\w*\.[a-z]*(\.[a-z]*)?\z/i
	validates :email, presence: true, format: {with: EMAIL},
	          uniqueness: {case_sensitive: false}

	before_save :create_remember_token

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

	#def follow!(other_user)
	#	relations.create!(followed: other_user.name)
	#end

    # all 'self's can be omitted
    def following?(other_user)
    	self.relationships.find_by_followed_id(other_user.id)
    end

    def follow!(other_user)
    	self.relationships.create!(followed_id: other_user.id)
    end

    def unfollow!(other_user)
    	self.relationships.find_by_followed_id(other_user.id).destroy
    end

    def he_is_good!(other_user)
        other_user.GoodOrBad = true
    end

    def he_is_bad!(other_user)
        other_user.GoodOrBad = false
    end

  private

    def create_remember_token
    	self.remember_token = SecureRandom.urlsafe_base64
    end

end
