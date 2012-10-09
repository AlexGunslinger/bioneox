class User < ActiveRecord::Base
	acts_as_authentic

	has_one :manage, :class_name => Site, :foreign_key => :user_id
	
	ROLES = %w[admin onsite carrier]
	
end
