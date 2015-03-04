namespace :scheduler do
	desc "Starts the Scheduler worker"
	task :scheduler => :environment do
		# require './app/assets/scheduler/scheduler.rb'

		require 'rufus-scheduler'

		scheduler = Rufus::Scheduler.new
		scheduler.every '10h' do
			Site.update_all

		end

		scheduler.join
	end
end