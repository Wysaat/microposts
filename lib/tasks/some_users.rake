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
end