namespace :db do
	desc "make some users for testing!"
	task populate: :environment do
		make_users
	end
	
end

def make_users
	admin = User.create!(name: 'Justin',
		                   email: 'justin@gmail.com',
		                   password: 'justinjustin',
		                   password_confirmation: 'justinjustin')
	admin.toggle!(:admin)

	100.times do |n|
		User.create!(name: Faker::Name.name,
			           email: "user#{n+1}@microposts.com",
			           password: 'password',
			           password_confirmation: 'password')
	end
end