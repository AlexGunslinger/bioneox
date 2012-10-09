class AddAddressToOrder < ActiveRecord::Migration
  def change
	add_column :orders, :name, :string
	add_column :orders, :address_name, :string
	add_column :orders, :alt_address, :text
	add_column :orders, :alt_city_id, :integer
	add_column :orders, :alt_state_id, :integer
	add_column :orders, :alt_zip_code, :string
	add_column :orders, :alt_phone, :string
	add_column :orders, :description, :text
  end
end
