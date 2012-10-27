class User < ActiveRecord::Base
	acts_as_authentic

	has_one :manage, :class_name => Site, :foreign_key => :user_id

  has_many :origin_orders, :class_name => Order, :foreign_key => :origin_user_id
  has_many :delivery_orders, :class_name => Order, :foreign_key => :delivery_user_id
  has_many :carrier_orders, :class_name => Order, :foreign_key => :carrier_id

	has_many :orders_submitted, :class_name => Order, :foreign_key => :submitted_by_id

  scope :sites, where("role = '2'")
  scope :carrier_companies, where("role = '3'")
  scope :doctors, where("role = '4'")
  
#	ROLES = %w[admin onsite carrier]

  ROLES = [["ADMIN", 1], ["CPLCC", 2], ["CCC", 3], ["DCPL", 4]]

  def role_name
    if self.role == "1"
      "ADMIN"
    elsif self.role == "2"
      "CPLCC"
    elsif self.role == "3"
      "CCC"
    else
      "DCPL"
    end
  end
  
	def is_admin?
  		if self.role == "1"
  			true
  		else
  			false
  		end
  	end

	def is_onsite?
  		if self.role == "2"
  			true
  		else
  			false
  		end
  	end

  	def is_carrier?
  		if self.role == "3"
  			true
  		else
  			false
  		end
  	end

    def is_doctor?
      if self.role == "4"
        true
      else
        false
      end
    end
end
