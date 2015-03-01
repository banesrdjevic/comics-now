namespace :scheduler do
	desc "Starts the Scheduler worker"
	task :scheduler => :environment do
		# require './app/assets/scheduler/scheduler.rb'

		require 'rufus-scheduler'

		scheduler = Rufus::Scheduler.new
		scheduler.every '1s' do
			apple = ['http://chicagofree.info/wp-content/uploads/2010/08/free-gyros.jpg', 'http://www.thestar.com/content/dam/thestar/opinion/editorials/star_s_view_/2011/10/12/an_apple_a_day_not_such_a_good_idea/apple.jpeg', 'http://www.defenders.org/sites/default/files/styles/large/public/grizzly-bear-harry-bosen-dpc.jpg'].sample
			site = Site.first
			site.picture_url = apple
			site.save

		end

		scheduler.join
	end
end