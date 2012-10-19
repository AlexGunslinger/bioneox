class AddPickedUpByToOrder < ActiveRecord::Migration
  def change
	add_column :orders, :picked_up_by, :string
  end
end
