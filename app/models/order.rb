class Order < ActiveRecord::Base
  	after_create :create_tracking_number

	belongs_to :origin_site, :class_name => Site, :foreign_key => :origin_site_id
	belongs_to :delivery_site, :class_name => Site, :foreign_key => :delivery_site_id
	
	belongs_to :carrier, :class_name => User, :foreign_key => :carrier_id
	belongs_to :submitted_by, :class_name => User, :foreign_key => :submitted_by_id
	belongs_to :picked_up_by_user, :class_name => User, :foreign_key => :picked_up_by_id
	
	belongs_to :order_type
	belongs_to :sample_type
		
	scope :for_carriers, :conditions => ["picked_up_at is null or delivered_at is null"]
	scope :sample_type, :conditions => ["order_type_id = 1"]

	TEMPERATURES = %w[Room Refrigerated Frozen]

	def status
		if self.picked_up_at == nil
			"Waiting for Carrier"
		elsif self.delivered_at == nil
			"In Transit"
		else
			"Delivered"
		end
	end

	def status_for_carrier
		if self.picked_up_at == nil
			"Waiting for Carrier"
		elsif self.delivered_at == nil
			"To be Delivered"
		else
			"Delivered"
		end
	end

	private
	
		def create_tracking_number
			if self.origin_site and self.name
				tracking_code = self.origin_site.code.to_s
				tracking_date = Date.today.strftime("%m%d%y")
				tracking_time = Time.now.strftime("%H%M")
				names = self.name.split(' ')
				tracking_name = names.first[0..0].to_s + names[1][0..0].to_s
				if self.urgency == "yes"
					rors = "S"
				elsif self.urgency == "no"
					rors = "R"
				else
					rors = "RO"
				end
				self.tracking_number = tracking_code + tracking_date + rors + tracking_time + tracking_name
			end
			self.save
		end
		
end
