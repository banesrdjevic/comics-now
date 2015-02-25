class User < ActiveRecord::Base

	has_many :users_sites
	has_many :sites, through: :users_sites

	has_secure_password

end