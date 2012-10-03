class User < ActiveRecord::Base
	acts_as_authentic
	
	ROLES = %w[admin onsite carrier]
	
end
