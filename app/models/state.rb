class State < ActiveRecord::Base
	has_many :cities
	has_many :orders
end
