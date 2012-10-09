class Order < ActiveRecord::Base
  	after_create :create_tracking_number

	belongs_to :origin_site, :class_name => Site, :foreign_key => :origin_site_id
	belongs_to :delivery_site, :class_name => Site, :foreign_key => :delivery_site_id
	
	belongs_to :carrier, :class_name => User, :foreign_key => :carrier_id
	belongs_to :submitted_by, :class_name => User, :foreign_key => :submitted_by_id
	belongs_to :picked_up_by, :class_name => User, :foreign_key => :picked_up_by_id
	
	belongs_to :order_type
	
	TEMPERATURES = %w[Room Refrigerated Frozen]


	private
	
		def create_tracking_number
			if self.origin_site and self.name
				tracking_code = self.origin_site.code.to_s
				tracking_date = Date.today.strftime("%d%m%y")
				tracking_time = Time.now.strftime("%H%M")
				names = self.name.split(' ')
				tracking_name = names.first[0..0].to_s + names[1][0..0].to_s
				self.tracking_number = tracking_code + tracking_date + "R" + tracking_time + tracking_name
			end
			self.save
		end
		
end
