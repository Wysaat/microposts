class User < ActiveRecord::Base
	attr_accessible :name, :email, :password, :password_confirmation
	has_secure_password

	validates(:name, { :presence => true })
	# validates :password, presence: true, { :length => { :minimum => 8 } }
	validates :password, presence: true, length: {minimum: 8}

	EMAIL = /\A\w*@\w*\.[a-z]*(\.[a-z]*)?\z/i
	validates :email, presence: true, format: {with: EMAIL},
	          uniqueness: {case_sensitive: false}

end
