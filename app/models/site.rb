class Site < ActiveRecord::Base

	has_many :users_sites
	has_many :users, through: :users_sites


end