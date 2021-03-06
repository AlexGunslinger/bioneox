class User < ActiveRecord::Base
	acts_as_authentic do |c|
    c.require_password_confirmation = false
  end

  belongs_to :dcpl
  validates_format_of :cell_number, :with => /^\d\d\d\d\d\d\d\d\d\d$/, :message => "Cell number must be of 10 digits.", :if => :need_cell?

  #validates_presence_of :dcpl_id, :message => "A Dcpl user must be assigned to a Dcpl.", :if => :need_dcpl?

	has_one :manage, :class_name => Site, :foreign_key => :user_id

  has_many :origin_orders, :class_name => Order, :foreign_key => :origin_user_id
  has_many :delivery_orders, :class_name => Order, :foreign_key => :delivery_user_id
  has_many :carrier_orders, :class_name => Order, :foreign_key => :carrier_id
  has_many :driver_orders, :class_name => Order, :foreign_key => :picked_up_by_id

	has_many :orders_submitted, :class_name => Order, :foreign_key => :submitted_by_id

  belongs_to :state
  belongs_to :city
  scope :sites, where("role = '2'")
  scope :carrier_companies, where("role = '3' or role = '5'")
  scope :doctors, where("role = '4'")
  scope :drivers, where("role = '6'")

#	ROLES = %w[admin onsite carrier]

  ROLES = [["ADMIN", 1], ["CPL", 2], ["Contract Carrier Company", 3], ["Origin", 4], ["CPL Driver", 5], ["Sigma Express Driver", 6]]

  def role_name
    if self.role == "1"
      "ADMIN"
    elsif self.role == "2"
      "CPLCC"
    elsif self.role == "3"
      "Contract Carrier Company"
    elsif self.role == "4"
      "Origin"
    elsif self.role == "5"
      "CPL Driver"
    elsif self.role == "6"
      "Sigma Express Driver"
    else
      ""
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

  def is_driver?
    if self.role == "6"
      true
    else
      false
    end
  end

  def is_ccc?
    role == "3"
  end

  def is_cpld?
    role == "5"
  end

  def need_cell?
    role == "3" or role == "5" or role == "6"
  end

  def need_dcpl?
    role == "4"
  end

  def valid_cell?
    resu = false
    if self.cell_number
      if self.cell_number.size == 10
        resu = true
      end
    end
    resu
  end

  def layout_name
    if self.role == "20" and self.dcpl
      self.name + " (" + self.dcpl.name + ")"
    else
      self.name
    end
  end

  def can_add_sites?
    if self.id == 41
      true
    else
      false
    end
  end

  def can_add_origin?
    if self.id == 41
      true
    else
      false
    end
  end

  def can_add_destination?
    if self.id == 41
      true
    else
      false
    end
  end
  
end
