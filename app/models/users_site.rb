class UsersSite < ActiveRecord::Base
	belongs_to :site
	belongs_to :user
	validates_uniqueness_of :users_id, :scope => :sites_id

end