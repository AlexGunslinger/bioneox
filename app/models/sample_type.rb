class SampleType < ActiveRecord::Base
	has_many :orders
	has_many :items
end