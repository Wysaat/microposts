class User < ActiveRecord::Base
	attr_accessible :name, :email, :password, :password_confirmation, :admin
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

	def follow!(other_user)
		relations.create!(followed: other_user.name)
	end


  private

    def create_remember_token
    	self.remember_token = SecureRandom.urlsafe_base64
    end

end
