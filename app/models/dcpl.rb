class Dcpl < ActiveRecord::Base
	has_many :orders
	has_many :users
	
	#belongs_to :manager, :class_name => User, :foreign_key => :user_id
	#has_many :submitted_orders, :class_name => Order, :foreign_key => :origin_site_id
	
	#has_many :orders, :class_name => Order, :foreign_key => :delivery_site_id
	 
end
