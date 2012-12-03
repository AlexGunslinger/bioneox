class Order < ActiveRecord::Base
  	#after_create :create_tracking_number

	belongs_to :origin_site, :class_name => Site, :foreign_key => :origin_site_id
	belongs_to :delivery_site, :class_name => Site, :foreign_key => :delivery_site_id
	
	belongs_to :carrier, :class_name => User, :foreign_key => :carrier_id
	belongs_to :submitted_by, :class_name => User, :foreign_key => :submitted_by_id
	belongs_to :driver, :class_name => User, :foreign_key => :picked_up_by_id
	
	belongs_to :origin_user, :class_name => User, :foreign_key => :origin_user_id
	belongs_to :delivery_user, :class_name => User, :foreign_key => :delivery_user_id

	belongs_to :order_type
	belongs_to :sample_type
	has_many :items
	validates_associated :items, :message => "Samples are invalid", :if => "order_type_id == 1"
	accepts_nested_attributes_for :items, allow_destroy: true
	validates_presence_of :items, :message => "You have to add at least one set of samples.", :if => "order_type_id == 1 or order_type_id == '1'"
	validates_presence_of :description, :message => "A quick order must have a description", :if => "order_type_id == 4 or order_type_id == '4'"

#validates_format_of :cell_number, :with => /^\d\d\d\d\d\d\d\d\d\d$/, :message => "Cell number must be of 10 digits.", :if => :need_cell?


	scope :for_carriers, :conditions => ["picked_up_at is null or delivered_at is null"]
	scope :sample_type, :conditions => ["order_type_id = 1"]

	TEMPERATURES = %w[Refrigerated Room Frozen]

	def status
		if self.delivered_at != nil
			stat = "Delivered"
		elsif self.picked_up_at != nil
			stat = "In Transit"
		elsif self.carrier_id != nil
			stat = "Waiting for Carrier"
		else
			stat = "Order Created"
		end
		stat
	end

	def status2
		if self.picked_up_at == nil
			stat = "Waiting for Carrier"
			if self.carrier_id != nil
				stat = "Carrier is on its way"
			end
		elsif self.delivered_at == nil
			stat = "In Transit"
		else
			stat = "Delivered"
		end
		stat
	end

	def status_for_carrier2
		if self.picked_up_at == nil
			"Waiting for Carrier"
		elsif self.delivered_at == nil
			"To be Delivered"
		else
			"Delivered"
		end
	end
	
	def create_tracking_number
		if self.origin_site
			tracking_code = self.origin_site.code.to_s
			tracking_date = Date.today.strftime("%m%d%y")
			tracking_time = Time.now.strftime("%H%M")
			if self.name
				names = self.name.split(' ')
			else
				names = self.submitted_by.name.split(' ')
			end
			tracking_name = names.first[0..0].to_s + names.last[0..0].to_s
			if self.urgency == "yes"
				rors = "S"
			elsif self.urgency == "no"
				rors = "R"
			else
				rors = "RO"
			end
			self.tracking_number = tracking_code + tracking_date + rors + tracking_time + tracking_name
			self.tracking_number = self.tracking_number.upcase
		end
		self.save
	end

	def send_sms
		number_to_send_to = self.carrier.cell_number
        twilio_sid = "AC5ba76291710e519fe5dfa6d5fb781e6e"
        twilio_token = "025d3928ae3e941bf2539b387caf0945"
        twilio_phone_number = "5125246907"
        hour1 = self.created_at.strftime("%H:%M")
        
        if self.urgency == "yes"
        	storou = "Stat"
        else
        	storou = "Routine"
        end

        if self.origin_user 
        	if self.origin_user.address
        		address = self.origin_user.name + " " + self.origin_user.address
        	else
        		address = self.origin_user.name
        	end
        end
        details = ""
        if self.order_type_id == 4
        	details = self.description + " "
        elsif self.order_type_id == 1
        	for o in self.items
        		details = details + o.quantity.to_s + " " + o.sample_type.name + " "
        	end
        end

        message1 = storou + " " + hour1 + " " + address + " " + details + self.id.to_s 

        @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

        @twilio_client.account.sms.messages.create(
          :from => "+1#{twilio_phone_number}",
          :to => "+521#{number_to_send_to}",
          :body => "#{message1}"
        )
	end

	def send_sms_to_driver
		number_to_send_to = self.driver.cell_number
        twilio_sid = "AC5ba76291710e519fe5dfa6d5fb781e6e"
        twilio_token = "025d3928ae3e941bf2539b387caf0945"
        twilio_phone_number = "5125246907"

        hour1 = self.created_at.strftime("%H:%M")
        
        if self.urgency == "yes"
        	storou = "Stat"
        else
        	storou = "Routine"
        end

        if self.origin_user 
        	if self.origin_user.address
        		address = self.origin_user.name + " " + self.origin_user.address
        	else
        		address = self.origin_user.name
        	end
        end
        details = ""
        if self.order_type_id == 4
        	details = self.description + " "
        elsif self.order_type_id == 1
        	for o in self.items
        		details = details + o.quantity.to_s + " " + o.sample_type.name + " "
        	end
        end

        message1 = storou + " " + hour1 + " " + address + " " + details + self.id.to_s 

        @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

        @twilio_client.account.sms.messages.create(
          :from => "+1#{twilio_phone_number}",
          :to => "+1#{number_to_send_to}",
          :body => "#{message1}"
        )
	end

	def send_call
		number_to_send_to = self.delivery_user.cell_number
        twilio_sid = "AC5ba76291710e519fe5dfa6d5fb781e6e"
        twilio_token = "025d3928ae3e941bf2539b387caf0945"
        twilio_phone_number = "5125246907"

        @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

        @twilio_client.account.calls.create(
          :from => "+1#{twilio_phone_number}",
          :to => "+1#{number_to_send_to}",
          :url => "http://obscure-dawn-7074.herokuapp.com/orders/#{self.id}/call.xml"
        )
	end

end
