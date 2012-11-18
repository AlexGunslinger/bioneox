class AddAddressToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :address, :text
  	add_column :users, :add_state_id, :integer
  	add_column :users, :add_city_id, :integer
  	add_column :users, :zip_code, :integer
  end
end
