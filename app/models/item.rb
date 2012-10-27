class Item < ActiveRecord::Base
	belongs_to :order
	belongs_to :sample_type

	validates_presence_of :sample_type_id, :message => "Samples Type can't be blank."
end
