class SampleType < ActiveRecord::Base
	validates_uniqueness_of :name

	has_many :orders
	has_many :items
end
