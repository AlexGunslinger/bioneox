class AddOriginUserToOrder < ActiveRecord::Migration
  def change
  	add_column :orders, :origin_user_id, :integer
  	add_column :orders, :delivery_user_id, :integer
  	add_column :orders, :carrier_name, :string
  	add_column :orders, :area, :string
	add_column :orders, :comments, :text
  end
end
