class User < ActiveRecord::Base
	acts_as_authentic

	has_one :manage, :class_name => Site, :foreign_key => :user_id
	
	ROLES = %w[admin onsite carrier]

	def is_admin?
  		if self.role == "admin"
  			true
  		else
  			false
  		end
  	end

	def is_onsite?
  		if self.role == "onsite"
  			true
  		else
  			false
  		end
  	end

  	def is_carrier?
  		if self.role == "carrier"
  			true
  		else
  			false
  		end
  	end

end
