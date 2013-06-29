namespace :db do
	desc "make some users for testing!"
	task populate: :environment do
		make_users
		make_microposts
		make_relationships
	end
	
end

def make_users
	admin = User.create!(name: 'Justin',
		                   email: 'justin@gmail.com',
		                   password: 'justinjustin',
		                   password_confirmation: 'justinjustin')
	admin.toggle!(:admin)

	100.times do |n|
		name = Faker::Name.name
		email = "#{n+1}@microposts.com"
		User.create!(name: name,
			           email: email,
			           password: 'password',
			           password_confirmation: 'password')
	end
end

def make_microposts
	users = User.all(limit: 6)
	50.times do
		content = Faker::Lorem.sentence(5)
		users.each { |user| user.microposts.create!(content: content) }
	end
end

def make_relationships
	users = User.all
	user = users.first
	followeds = users[2..50]
	followers = users[3..40]
	followeds.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end