# you can group tasks by placing them in namespaces
namespace :db do
	desc "make some users for testing!"
	task populate: :environment do
		make_users
		make_relationships
		make_microposts
		make_random_votes
	end

	task repair: :environment do
		init_some_data
	end

	task pcomment: :environment do
		init_pcomment
	end
	
end

def init_pcomment
	pcomment = Pcomment.new
	pcomment.update_attribute(:good, 0)
	pcomment.update_attribute(:bad, 0)
end

def init_some_data
	User.all.each do |user|
		user.update_attribute(:topics_num, 0) unless user.topics_num
		user.update_attribute(:comments_num, 0) unless user.comments_num
		user.update_attribute(:pages, 0) unless user.pages
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
	users = User.all
	users.each do |user|
		rand(100).times do
			content = rand_content
			user.microposts.create!(content: content)
		end
	end
end

def make_relationships
	users = User.all
	count = users.size

	500.times do
		follower = users[rand(count)]
		followed = users[rand(count)]
		unless follower.following?(followed) or follower == followed
			follower.follow!(followed)
		end
	end
end

def make_random_votes
	users = User.all
	countu = users.size
	microposts = Micropost.all
	countm = microposts.size

  500.times do
	  voter = users[rand(countu)]
	  voted = microposts[rand(countm)]
    begin
  	  rand_vote(voter, voted)
    rescue
    end
  end
end

def rand_vote(voter, voted)
	case rand(3)
	when 0
		voter.upvote!(voted)
	when 1
		voter.downvote!(voted)
	when 2
		voter.inappropriate!(voted)
	end
end

def rand_content
	f = File.open(File.join(Rails.root, 'lib', 'tasks', 'galaxy.txt'))

	count = f.each_line.count
	f.each_line.rewind
	lines = f.each_line.first(count)

	lines[rand(count)].chomp![0..140]
end