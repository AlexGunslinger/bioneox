class AddSampleTypeToOrder < ActiveRecord::Migration
  def change
  	add_column :orders, :sample_type_id, :integer
  end
end
